//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Simulated authorization response.
public struct SimulateAuthorizationResponse: Equatable {

    // MARK: - Properties

    /// ID of authorization response. If approved, ID may be used in subsequent incremental authorizations, reversals and debits.
    public var id: String

    /// Whether or not authorization is approved.
    public var approved: Bool

    /// Amount billed in card's currency.
    public var billedAmount: CurrencyAmount

    /// Decline reason code. Only present if not approved.
    public var declineReason: String?

    /// Date/timestamp response was created at.
    public var createdAt: Date

    /// Date/timestamp response was last updated at.
    public var updatedAt: Date

    // MARK: - Lifecycle

    /// Initialize an instance of `SimulateAuthorizationResponse`.
    public init(id: String, approved: Bool, billedAmount: CurrencyAmount, createdAt: Date, updatedAt: Date, declineReason: String? = nil) {
        self.id = id
        self.approved = approved
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.billedAmount = billedAmount
        self.declineReason = declineReason
    }
}
