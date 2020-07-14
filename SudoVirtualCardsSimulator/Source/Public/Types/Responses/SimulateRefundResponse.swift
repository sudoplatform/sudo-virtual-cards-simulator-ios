//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Simulated refund response.
public struct SimulateRefundResponse: Equatable {

    // MARK: - Properties

    /// ID of refund response.
    public var id: String

    /// Date/timestamp response was created at.
    public var createdAt: Date

    /// Date/timestamp response was last updated at.
    public var updatedAt: Date

    /// Amount refunded in card's currency.
    public var billedAmount: CurrencyAmount

    // MARK: - Lifecycle

    /// Initialize an instance of `SimulateRefundResponse`.
    public init(id: String, createdAt: Date, updatedAt: Date, billedAmount: CurrencyAmount) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.billedAmount = billedAmount
    }
}
