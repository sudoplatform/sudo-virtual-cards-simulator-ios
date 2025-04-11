//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient

/// A protocol defining a client for executing GraphQL operations, including queries, mutations, and subscriptions.
protocol GraphQLClient {

    /// Executes a GraphQL query and returns the result.
    /// - Parameter query: The `GraphQLQuery` to execute.
    /// - Returns: The decoded response data of type `Q.Data`.
    /// - Throws: An error if the request fails or decoding is unsuccessful.
    @discardableResult
    func query<Q: GraphQLQuery>(_ query: Q) async throws -> Q.Data

    /// Executes a GraphQL mutation and returns the result.
    /// - Parameter mutation: The `GraphQLMutation` to execute.
    /// - Returns: The decoded response data of type `M.Data`.
    /// - Throws: An error if the request fails or decoding is unsuccessful.
    @discardableResult
    func mutate<M: GraphQLMutation>(_ mutation: M) async throws -> M.Data
}
