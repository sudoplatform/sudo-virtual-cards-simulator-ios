//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

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
    /// Attempt to reverse an amount larger than the remaining pending amount of an authorization
    case excessiveReversal
    /// Attempt to refund an amount larger than the remaining settled amount of a debit
    case excessiveRefund
    /// Attempt to expiry an authorization that is already expired
    case alreadyExpired
    /// Transaction type is invalid/illegal.
    case InvalidTransactionType
    /// Simulate authorization API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateAuthorizationFailed
    /// Simulate incremental authorization API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateIncrementalAuthorizationFailed
    /// Simulate reversal API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateReversalFailed
    /// Simulate authorization expiry API call failed generically - this is generally a sign of a programmatic failure or bug within the kit.
    case simulateAuthorizationExpiryFailed
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
    /// Indicates that the request operation failed due to authorization error. This maybe due to the authentication
    /// token being invalid or other security controls that prevent the user from accessing the API.
    case notAuthorized
    /// Operation failed due to an invalid request. This maybe due to the version mismatch between the
    /// client and the backend.
    case invalidRequest
    /// Indicates that there were too many attempts at sending API requests within a short period of time.
    case rateLimitExceeded
    /// Indicates that an internal server error caused the operation to fail. The error is possibly transient and
    /// retrying at a later time may cause the operation to complete successfully
    case serviceError
    /// Indicates that a GraphQL error was returned by the backend.
    case graphQLError(description: String)
    /// An internal error has occurred - contact the SudoPlatform team for more information.
    case internalError(_ cause: String)
    /// Indicates that the request failed due to connectivity, availability or access error.
    case requestFailed(response: HTTPURLResponse?, cause: Error?)
    /// Indicates that a fatal error occurred. This could be due to coding error, out-of-memory condition or other
    /// conditions that is beyond control of `SudoVirtualCardsSimulator` implementation.
    case fatalError(description: String)

    // MARK: - Conformance: Equatable

    public static func == (lhs: SudoVirtualCardsSimulatorError, rhs: SudoVirtualCardsSimulatorError) -> Bool {
        switch (lhs, rhs) {
        case (.requestFailed(let lhsResponse, let lhsCause), requestFailed(let rhsResponse, let rhsCause)):
            if let lhsResponse = lhsResponse, let rhsResponse = rhsResponse {
                return lhsResponse.statusCode == rhsResponse.statusCode
            }
            return type(of: lhsCause) == type(of: rhsCause)
        case (.alreadyExpired, .alreadyExpired),
             (.cardNotFound, .cardNotFound),
             (.cardStateError, .cardStateError),
             (.currencyMismatch, .currencyMismatch),
             (.excessiveRefund, .excessiveRefund),
             (.excessiveReversal, .excessiveReversal),
             (.fatalError, .fatalError),
             (.getSimulatorConversionRatesFailed, .getSimulatorConversionRatesFailed),
             (.getSimulatorMerchantsFailed, .getSimulatorMerchantsFailed),
             (.graphQLError, .graphQLError),
             (.internalError, .internalError),
             (.invalidConfig, .invalidConfig),
             (.InvalidTransactionType, .InvalidTransactionType),
             (.merchantNotFound, .merchantNotFound),
             (.notAuthorized, .notAuthorized),
             (.notSignedIn, .notSignedIn),
             (.rateLimitExceeded, .rateLimitExceeded),
             (.serviceError, .serviceError),
             (.simulateAuthorizationFailed, .simulateAuthorizationFailed),
             (.simulateAuthorizationExpiryFailed, .simulateAuthorizationExpiryFailed),
             (.simulateCreditFailed, .simulateCreditFailed),
             (.simulateDebitFailed, .simulateDebitFailed),
             (.simulateIncrementalAuthorizationFailed, .simulateIncrementalAuthorizationFailed),
             (.simulateRefundFailed, .simulateRefundFailed),
             (.simulateReversalFailed, .simulateReversalFailed),
             (.transactionNotFound, .transactionNotFound):
            return true
        default:
            return false
        }
    }
}
