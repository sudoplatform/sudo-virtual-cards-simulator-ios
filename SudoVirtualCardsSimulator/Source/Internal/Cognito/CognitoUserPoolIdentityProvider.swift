//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import AWSMobileClient
import AWSAppSync
import SudoOperations

/// Provides the authentication for all GraphQL API calls to the Simulator Service.
///
/// This is used when the client is configured to be authenticated via Cognito User Pools.
class SimulatorCognitoUserPoolAuthProvider: AWSCognitoUserPoolsAuthProviderAsync {

    // MARK: - Supplementary

    /// Typealias for all callback completions used in `AWSCognitoUserPoolsAuthProviderAsync.getLatestAuthToken`
    typealias CallbackCompletion = (String?, Error?) -> Void

    // MARK: - Properties

    /// Username to authenticate with the user pool.
    var username: String

    /// Password to authenticate with the user pool.
    var password: String

    /// Internal mobile client used to perform the authentication via the user pool.
    let authenticator: UserPoolAuthenticator

    /// Platform Operation Queue used to run the operations.
    var queue: PlatformOperationQueue = PlatformOperationQueue()

    /// Logging instance.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `SimulatorCognitoUserPoolAuthProvider`.
    ///
    /// - Parameters:
    ///   - poolId: Id of the user pool to authenticate against.
    ///   - clientId: Client Pool Id to authenticate against.
    ///   - region: Region that the user pool resides in.
    ///   - username: Username to use to authenticated with.
    ///   - password: Password to use to authenticate with.
    ///   - logger: Logging instance.
    convenience init(poolId: String, clientId: String, region: AWSRegionType, username: String, password: String, logger: Logger) {
        let configuration = SimulatorCognitoUserPoolAuthProvider.generateConfiguration(poolId: poolId, clientId: clientId, region: region)
        let authenticator = AWSUserPoolAuthenticator(configuration: configuration)
        self.init(authenticator: authenticator, username: username, password: password, logger: logger)
    }

    init(authenticator: UserPoolAuthenticator, username: String, password: String, logger: Logger) {
        self.authenticator = authenticator
        self.username = username
        self.password = password
        self.logger = logger
    }

    // MARK: - Helpers: Static

    static func generateConfiguration(poolId: String, clientId: String, region: AWSRegionType) -> [String: Any] {
        return [
            "CognitoUserPool": [
                "Default": [
                    "PoolId": poolId,
                    "AppClientId": clientId,
                    "Region": region.string
                ]
            ]
        ]
    }

    // MARK: - Helpers

    /// Generates a finish handler, used in a `PlaformBlockObserver` that is attached to all operations spawned in this class.
    ///
    /// - Parameter callback: Callback from `getLatestAuthToken(_:)` to embed in a finish handler.
    func generateFinishHandler(callback: @escaping CallbackCompletion) -> PlatformBlockObserver.FinishHandler {
        return { operation, errors in
            // Catch all error handles
            guard errors.isEmpty else {
                callback(nil, errors.first)
                return
            }
            /// From this point onward we only care about results from `UserPoolsGetTokenOperation`.
            guard let operation = operation as? UserPoolsGetTokenOperation else {
                return
            }
            callback(operation.result, nil)
        }
    }

    // MARK: - Conformance: AWSCognitoUserPoolsAuthProviderAsync

    func getLatestAuthToken(_ callback: @escaping CallbackCompletion) {
        authenticator.initialize { state, error in
            if let error = error {
                callback(nil, error)
                return
            }
            guard let state = state else {
                /// This error should **never** occur.
                callback(nil, SudoVirtualCardsSimulatorError.internalError)
                return
            }
            let operationCompletionObserver = PlatformBlockObserver(finishHandler: self.generateFinishHandler(callback: callback))
            let getTokenOperation = UserPoolsGetTokenOperation(authenticator: self.authenticator, logger: self.logger)
            getTokenOperation.addObserver(operationCompletionObserver)
            if state != .signedIn {
                let signInOperation = UserPoolsSignInOperation(
                    username: self.username,
                    password: self.password,
                    authenticator: self.authenticator,
                    logger: self.logger
                )
                signInOperation.addObserver(operationCompletionObserver)
                getTokenOperation.addDependency(signInOperation)
                self.queue.addOperation(signInOperation)
            }
            self.queue.addOperation(getTokenOperation)
        }
    }
}
