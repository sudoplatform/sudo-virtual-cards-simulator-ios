//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation

/// Utility for transforming error types to the public `ApiOperationError` defined in this SDK.
enum SudoVirtualCardsSimulatorErrorTransformer {

    // MARK: - Supplementary

    enum SudoPlatformServiceError {
        static let type = "errorType"
        static let conditionalCheckFailedException = "DynamoDB:ConditionalCheckFailedException"
        static let decodingError = "sudoplatform.DecodingError"
        static let invalidArgumentError = "sudoplatform.InvalidArgumentError"
        static let limitExceededError = "sudoplatform.LimitExceededError"
        static let serviceError = "sudoplatform.ServiceError"
    }

    enum VirtualCardsServiceError {
        static let cardNotFound = "sudoplatform.virtual-cards.CardNotFoundError"
        static let cardStateError = "sudoplatform.virtual-cards.CardStateError"
        static let transactionNotFound = "sudoplatform.virtual-cards.TransactionNotFoundError"
        static let currencyMismatch = "sudoplatform.virtual-cards.CurrencyMismatchError"
        static let merchantNotFound = "sudoplatform.virtual-cards.MerchantNotFoundError"
        static let InvalidTransactionType = "sudoplatform.virtual-cards.InvalidTransactionTypeError"
        static let excessiveReversal = "sudoplatform.virtual-cards.ExcessiveReversalError"
        static let excessiveRefund =  "sudoplatform.virtual-cards.ExcessiveRefundError"
        static let alreadyExpired = "sudoplatform.virtual-cards.AlreadyExpiredError"
    }

    // MARK: - Methods

    static func transformError<T: Decodable>(_ error: Error, type: T.Type) -> SudoVirtualCardsSimulatorError {
        if let operationError = error as? SudoVirtualCardsSimulatorError {
            return operationError
        }
        if let graphQLResponseError = error as? GraphQLResponseError<T> {
            return transformGraphQLResponseError(graphQLResponseError)
        }
        if let apiError = error as? APIError {
            return transformApiError(apiError)
        }
        return SudoVirtualCardsSimulatorError.graphQLError(description: error.localizedDescription)
    }

    // MARK: - Helpers

    static func transformApiError(_ apiError: APIError) -> SudoVirtualCardsSimulatorError {
        if let authError = apiError.underlyingError as? AuthError {
            return transformAuthError(authError)
        }
        switch apiError {
        case .unknown:
            return .internalError(apiError.localizedDescription)

        case .invalidURL:
            return .invalidRequest

        case .operationError:
            return .serviceError

        case .networkError:
            return .requestFailed(response: nil, cause: apiError.underlyingError)

        case .httpStatusError(let statusCode, let response):
            if statusCode == 401 {
                return .notAuthorized
            }
            return .requestFailed(response: response, cause: nil)

        case .invalidConfiguration(let description, _, _):
            return .fatalError(description: "Invalid configuration: \(description)")

        case .pluginError(let error):
            if error is AuthError {
                return .notAuthorized
            }
            return .fatalError(description: "Amplify plugin error: \(error.errorDescription)")
        }
    }

    static func transformGraphQLResponseError<T: Decodable>(_ error: GraphQLResponseError<T>) -> SudoVirtualCardsSimulatorError {
        switch error {
        case .error(let graphQLErrors), .partial(_, let graphQLErrors):
            for graphQLError in graphQLErrors {
                if let transformedGraphQLError = transformGraphQLError(graphQLError) {
                    return transformedGraphQLError
                }
            }
            return .fatalError(description: "GraphQL operation failed but error type was not found in the response.")

        case .transformationError(_, let apiError):
            return transformApiError(apiError)

        case .unknown(let description, _, _):
            return .fatalError(description: description)
        }
    }

    static func transformGraphQLError(_ graphQLError: GraphQLError) -> SudoVirtualCardsSimulatorError? {
        guard let errorType = graphQLError.extensions?[SudoPlatformServiceError.type]?.stringValue else {
            return nil
        }
        switch errorType {
        case SudoPlatformServiceError.invalidArgumentError:
            return .invalidRequest

        case SudoPlatformServiceError.limitExceededError:
            return .rateLimitExceeded

        case SudoPlatformServiceError.conditionalCheckFailedException:
            return .invalidRequest

        case SudoPlatformServiceError.decodingError:
            return .invalidRequest

        case SudoPlatformServiceError.serviceError:
            return .serviceError

        case VirtualCardsServiceError.cardNotFound:
            return .cardNotFound

        case VirtualCardsServiceError.cardStateError:
            return .cardStateError

        case VirtualCardsServiceError.transactionNotFound:
            return .transactionNotFound

        case VirtualCardsServiceError.currencyMismatch:
            return .currencyMismatch

        case VirtualCardsServiceError.merchantNotFound:
            return .merchantNotFound

        case VirtualCardsServiceError.InvalidTransactionType:
            return .InvalidTransactionType

        case VirtualCardsServiceError.excessiveReversal:
            return .excessiveReversal

        case VirtualCardsServiceError.excessiveRefund:
            return .excessiveRefund

        case VirtualCardsServiceError.alreadyExpired:
            return .alreadyExpired

        default:
            return .graphQLError(description: graphQLError.localizedDescription)
        }
    }

    static func transformAuthError(_ authError: AuthError) -> SudoVirtualCardsSimulatorError {
        switch authError {
        case .signedOut:
            return SudoVirtualCardsSimulatorError.notSignedIn

        case .notAuthorized, .validation, .configuration, .sessionExpired, .invalidState, .service, .unknown:
            return SudoVirtualCardsSimulatorError.notAuthorized
        }
    }
}
