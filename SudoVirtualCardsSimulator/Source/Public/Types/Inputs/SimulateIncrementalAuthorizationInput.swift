//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Request to simulate an incremental authorization request from a merchant.
public struct SimulateIncrementalAuthorizationInput: Equatable {

    // MARK: - Properties

    /// Amount of transaction in merchant's currency.
    public var amount: Int

    /// ID of previous successful authorization to which this incremental authorization corresponds.
    public var authorizationId: String

    // MARK: - Lifecycle

    /// Initialize an instance of `InstanceSimulateIncrementalAuthorizationInput`.
    public init(amount: Int, authorizationId: String) {
        self.amount = amount
        self.authorizationId = authorizationId
    }
}
