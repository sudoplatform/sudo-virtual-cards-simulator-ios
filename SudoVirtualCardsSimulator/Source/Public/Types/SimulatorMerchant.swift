//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of a simulated merchant
public struct SimulatorMerchant: Equatable {

    // MARK: - Properties

    /// ID of the merchant for use in simulated transaction requests.
    public var id: String

    /// Name of merchant - used as tranaction descriptions.
    public var name: String

    /// Merchant category code of merchant.
    public var mcc: String

    /// City of merchant.
    public var city: String

    /// State of merchant.
    public var state: String?

    /// Postal code of merchant.
    public var postalCode: String

    /// Country of merchant.
    public var country: String

    /// Currency ISO code charged by merchant.
    public var currency: String

    /// Depicts that a transaction request made to this merchant will be authorized at the virtual cards service level, and then immediately declined once it
    /// reaches the 'provider level.
    public var declineAfterAuthorization: Bool

    /// Depicts that a transaction request made to this merchant will be automatically declined before it reaches the authorization level at the Virtual Card
    /// Service.
    public var declineBeforeAuthorization: Bool

    /// Date/timestamp that this resource was created.
    public var createdAt: Date

    /// Date/timestamp that this resource was last updated.
    public var updatedAt: Date

    // MARK: - Lifecycle

    /// Initialize an instance of `SimulatorMerchant`.
    public init(
        id: String,
        name: String,
        mcc: String,
        city: String,
        state: String?,
        postalCode: String,
        country: String,
        currency: String,
        declineAfterAuthorization: Bool,
        declineBeforeAuthorization: Bool,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.name = name
        self.mcc = mcc
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
        self.currency = currency
        self.declineAfterAuthorization = declineAfterAuthorization
        self.declineBeforeAuthorization = declineBeforeAuthorization
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
