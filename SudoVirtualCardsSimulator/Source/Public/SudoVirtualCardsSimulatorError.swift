//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync

/// Errors receieved from virtual cards simulator.
public enum SudoVirtualCardsSimulatorError: Error, Equatable {
    /// Not signed in.
    case notSignedIn
    /// Configuration is invalid.
    case invalidConfig
    /// Card information supplied did not match any record on the service.
    case cardNotFound
    /// Card is in a state that is considered irregular.
    case cardStateError
    /// Transaction information supplied did not match a transaction on the service.
    case transactionNotFound
    /// Two currency types do not match or are unsupported.
    case currencyMismatch
    /// Merchant information supplied did not match a merchant on the service.
    case merchantNotFound
    /// Transaction type is invalid/illegal.
    case InvalidTransactionType
    /// Simulate authorization API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateAuthorizationFailed
    /// Simulate incremental authorization API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateIncrementalAuthorizationFailed
    /// Simulate reversal API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateReversalFailed
    /// Simulate refund API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateRefundFailed
    /// Simulate credit API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateCreditFailed
    /// Simulate debit API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateDebitFailed
    /// Get simulator merchants API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case getSimulatorMerchantsFailed
    /// Get simulator conversion rates API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case getSimulatorConversionRatesFailed
    /// An internal error has occurred - contact the SudoPlatform team for more information.
    case internalError

    /// Initialize an instance of `SudoVirtualCardsSimulatorError`.
    /// - Parameter error: GraphQL Error to be converted to a `SudoVirtualCardsSimulatorError`.
    init?(_ error: GraphQLError) {
        guard let errorType = error["errorType"] as? String else {
            return nil
        }
        switch errorType {
        case "sudoplatform.virtual-cards.CardNotFoundError":
            self = .cardNotFound
        case "sudoplatform.virtual-cards.CardStateError":
            self = .cardStateError
        case "sudoplatform.virtual-cards.TransactionNotFoundError":
            self = .transactionNotFound
        case "sudoplatform.virtual-cards.CurrencyMismatchError":
            self = .currencyMismatch
        case "sudoplatform.virtual-cards.MerchantNotFoundError":
            self = .merchantNotFound
        case "sudoplatform.virtual-cards.InvalidTransactionTypeError":
            self = .InvalidTransactionType
        default:
            return nil
        }
    }
}
