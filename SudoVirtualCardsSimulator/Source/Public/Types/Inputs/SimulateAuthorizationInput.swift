//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoVirtualCards

/// Input to simulate an authorization request from a merchant.
public struct SimulateAuthorizationInput: Equatable {

    // MARK: - Properties

    /// Card number presented to merchant.
    public var pan: String

    /// Amount of transaction in merchant's minor currency (e.g. cents for USD).
    public var amount: Int

    /// ID of merchant to use in simulated authorization.
    public var merchantId: String

    /// Simulation of card expiry entered by user at merchant checkout.
    public var expiry: Card.Expiry

    /// Simulation of billing address entered by user at merchant checkout. If absent, will be treated as a `NOT_PROVIDED` on the simulation for AVS check.
    public var billingAddress: Card.BillingAddress?

    /// Simulation of card security code entered by user at merchant checkout. If absent, will be treated as a `NOT_PROVIDED` on the simulation for the CSC
    /// check.
    public var csc: String?

    // MARK: - Lifecycle

    /// Initialize an instance of `SimulateAuthorizationInput`.
    public init(pan: String, amount: Int, merchantId: String, expiry: Card.Expiry, billingAddress: Card.BillingAddress?, csc: String?) {
        self.pan = pan
        self.amount = amount
        self.merchantId = merchantId
        self.billingAddress = billingAddress
        self.expiry = expiry
        self.csc = csc
    }
}
