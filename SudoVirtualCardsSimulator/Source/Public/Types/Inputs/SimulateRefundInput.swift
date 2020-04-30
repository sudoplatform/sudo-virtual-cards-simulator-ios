//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input to simulate a refund request from a merchant.
public struct SimulateRefundInput: Equatable {

    // MARK: - Properties

    /// Amount of refund in merchant's currency.
    public var amount: Int

    /// ID of previous successful debit to which this refund corresponds.
    public var debitId: String

    // MARK: - Lifecycle

    /// Initialize an instance of `InstanceSimulateRefundInput`.
    public init(amount: Int, debitId: String) {
        self.amount = amount
        self.debitId = debitId
    }
}
