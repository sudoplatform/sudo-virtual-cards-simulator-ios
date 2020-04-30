//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Simulate a settlement of an authorized amount. Other attributes of the debit such as merchant info are derived from the original authorization identified by
/// the authorizationId.
public struct SimulateDebitInput: Equatable {

    // MARK: - Properties

    /// Amount of transaction in merchant's currency.
    public var amount: Int

    /// ID of previous successful authorization to which this debit corresponds.
    public var authorizationId: String

    // MARK: - Lifecycle

    /// Initialize an instance of `InstanceSimulateDebitInput`.
    public init(amount: Int, authorizationId: String) {
        self.amount = amount
        self.authorizationId = authorizationId
    }
}
