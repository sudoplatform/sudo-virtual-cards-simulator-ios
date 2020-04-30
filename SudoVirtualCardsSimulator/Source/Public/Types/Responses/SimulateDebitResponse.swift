//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Simulated debit response.
public struct SimulateDebitResponse: Equatable {

    // MARK: - Properties

    /// ID of debit response.
    public var id: String

    /// Date/timestamp response was created at.
    public var createdAt: Date

    /// Date/timestamp response was last updated at.
    public var updatedAt: Date

    // MARK: - Lifecycle

    /// Initialize an instance of `SimulateDebitResponse`.
    public init(id: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
