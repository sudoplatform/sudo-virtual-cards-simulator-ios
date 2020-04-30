//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import AWSAppSync
import SudoLogging

/// Operation Factory used to generate and inject query/mutation operations.
class OperationFactory {

    /// Generate a Query Operation.
    ///
    /// - Parameters:
    ///   - query: Query to be used for the operation.
    ///   - appSyncClient: `AWSAppSyncClient` used to perform the query.
    ///   - cachePolicy: Cache policy to use for the query.
    /// - Returns: Constructed Query operation to be added to a `PlatformOperationQueue`.
    func generateQueryOperation<Query: GraphQLQuery>(
        query: Query,
        appSyncClient: AWSAppSyncClient,
        cachePolicy: SudoOperations.CachePolicy,
        logger: Logger
    ) -> PlatformQueryOperation<Query> {
        return PlatformQueryOperation(appSyncClient: appSyncClient, query: query, cachePolicy: cachePolicy, logger: logger)
    }

    /// Generate a Mutation Operation.
    /// - Parameters:
    ///   - mutation: Mutation to be used for the operation.
    ///   - optimisticUpdate: Closure to control how to handle real-time event of updating data locally before sending a request to the service.
    ///   - optimisticCleanup: Closure to clean up any optimistic work performed and replace with the incoming data.
    ///   - appSyncClient: `AWSAppSyncClient` used to perform the mutation.
    ///   - serviceErrorTransformations: Array of closures to handle transformation of different error types.
    /// - Returns: Constructed Mutation operation to be added to a `PlatformMutationOperation`.
    func generateMutationOperation<Mutation: GraphQLMutation>(
        mutation: Mutation,
        optimisticUpdate: OptimisticResponseBlock? = nil,
        optimisticCleanup: OptimisticCleanupBlock? = nil,
        appSyncClient: AWSAppSyncClient,
        serviceErrorTransformations: [ServiceErrorTransformationCompletion]? = nil,
        logger: Logger
    ) -> PlatformMutationOperation<Mutation> {
        var tranformations: [ServiceErrorTransformationCompletion] = [SudoVirtualCardsSimulatorError.init(_:)]
        if let inputTransformations = serviceErrorTransformations {
            tranformations.append(contentsOf: inputTransformations)
        }
        return PlatformMutationOperation(
            appSyncClient: appSyncClient,
            serviceErrorTransformations: tranformations,
            mutation: mutation,
            optimisticUpdate: optimisticUpdate,
            optimisticCleanup: optimisticCleanup,
            logger: logger)
    }
}
