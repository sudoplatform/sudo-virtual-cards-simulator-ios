//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoLogging
import SudoApiClient

/// Typealias for a closure used for performing any optimistic cleanup on a mutation.
typealias OptimisticCleanupBlock = (ApolloStore.ReadWriteTransaction) throws -> Void

/// Typealias for a closure used for transforming a GraphQLError into a suitable consumer Error.
typealias ServiceErrorTransformationCompletion = (GraphQLError) -> Error?

struct GraphQLHelper {

    /// Queue to handle the result events from AWS.
    private static let dispatchQueue = DispatchQueue(label: "com.sudoplatform.mutation-result-handler-queue"
    )

    static func performMutation<Mutation: GraphQLMutation>(
        graphQLClient: SudoApiClient,
        serviceErrorTransformations: [ServiceErrorTransformationCompletion]? = nil,
        mutation: Mutation,
        optimisticUpdate: OptimisticResponseBlock? = nil,
        optimisticCleanup: OptimisticCleanupBlock? = nil,
        logger: Logger
    ) async throws -> Mutation.Data {
        do {
            let (result, error) = try await graphQLClient.perform(
                mutation: mutation,
                queue: dispatchQueue,
                optimisticUpdate: optimisticUpdate)
            if let error = error {
                switch error {
                case ApiOperationError.graphQLError(let cause):
                    if
                        let serviceErrorTransformations = serviceErrorTransformations,
                        let serviceError = serviceErrorTransformations.compactMap({$0(cause)}).first {
                        throw serviceError
                    } else {
                        throw SudoVirtualCardsSimulatorError(cause)
                    }
                default:
                    throw SudoVirtualCardsSimulatorError.fromApiOperationError(error: error)
                }
            }
            if let optimisticCleanup = optimisticCleanup {
                _ = graphQLClient.getAppSyncClient().store?.withinReadWriteTransaction(optimisticCleanup)
            }
            guard let data = result?.data else {
                throw SudoVirtualCardsSimulatorError.internalError("Missing data from API call")
            }
            return data
        } catch let error as ApiOperationError {
            throw SudoVirtualCardsSimulatorError.fromApiOperationError(error: error)
        }
    }

    static func performQuery<Query: GraphQLQuery>(
        graphQLClient: SudoApiClient,
        query: Query,
        serviceErrorTransformations: [ServiceErrorTransformationCompletion]? = nil,
        logger: Logger
    ) async throws -> Query.Data? {
        do {
            let (result, error) = try await graphQLClient.fetch(query: query, queue: dispatchQueue)
            if let error = error {
                switch error {
                case ApiOperationError.graphQLError(let cause):
                    if let serviceErrorTransformations = serviceErrorTransformations,
                       let serviceError = serviceErrorTransformations.compactMap({$0(cause)}).first {
                        throw serviceError
                    } else {
                        throw SudoVirtualCardsSimulatorError(cause)
                    }
                default:
                    throw SudoVirtualCardsSimulatorError.fromApiOperationError(error: error)
                }
            }
            return result?.data
        } catch let error as ApiOperationError {
            throw SudoVirtualCardsSimulatorError.fromApiOperationError(error: error)
        }
    }
}
