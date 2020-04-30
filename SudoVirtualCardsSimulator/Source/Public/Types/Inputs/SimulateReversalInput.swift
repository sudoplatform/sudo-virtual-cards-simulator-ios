//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input to simulate a reversal request from a merchant.
public struct SimulateReversalInput: Equatable {

    // MARK: - Properties

    /// Amount of reversal in merchant's currency.
    public var amount: Int

    /// ID of previous successful authorization to which this reversal corresponds.
    public var authorizationId: String

    // MARK: - Lifecycle

    /// Initialize an instance of `SimulateReversalInput`.
    public init(amount: Int, authorizationId: String) {
        self.amount = amount
        self.authorizationId = authorizationId
    }
}
