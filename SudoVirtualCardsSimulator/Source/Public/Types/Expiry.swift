//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of an Expiry data structure for depicting a card expiration date.
public struct Expiry: Equatable {

    // MARK: - Properties

    /// Month specifier, in format MM. e.g. (7 == July).
    public var mm: Int

    /// Year specifier, in format YYYY. e.g. (2020 == Year 2020).
    public var yyyy: Int

    // MARK: - Lifecycle

    /// Initialize an instance of a `Expiry`.
    public init(mm: Int, yyyy: Int) {
        self.mm = mm
        self.yyyy = yyyy
    }
}
