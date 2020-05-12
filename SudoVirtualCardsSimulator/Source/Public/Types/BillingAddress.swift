//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of an BillingAddress data structure for depicting a card/funding source billing address.
public struct BillingAddress: Equatable {

    // MARK: - Properties

    /// First line of the address.
    public var addressLine1: String

    /// Second line of the address.
    public var addressLine2: String?

    /// City of the address.
    public var city: String

    /// State of the address.
    public var state: String

    /// Postal code of the address.
    public var postalCode: String

    /// Country of the address.
    public var country: String

    // MARK: - Lifecycle

    /// Initialize an instance of `BillingAddress`.
    public init(addressLine1: String, addressLine2: String? = nil, city: String, state: String, postalCode: String, country: String) {
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
    }
}
