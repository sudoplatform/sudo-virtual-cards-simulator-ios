//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import AWSCore
import AWSAppSync

/// Provides the authentication for all GraphQL API calls to the Simulator Service.
///
/// This is used when the client is configured to be authenticated via Cognito User Pools.
class SimulatorCognitoUserPoolAuthProvider: AWSCognitoUserPoolsAuthProviderAsync {

    // MARK: - Properties

    /// Username to authenticate with the user pool.
    var username: String

    /// Password to authenticate with the user pool.
    var password: String

    /// Internal mobile client used to perform the authentication via the user pool.
    let authenticator: UserPoolAuthenticator

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

    // MARK: - Conformance: AWSCognitoUserPoolsAuthProviderAsync

    func getLatestAuthToken(_ callback: @escaping (String?, Error?) -> Void) {
        Task.detached(priority: .medium) {
            do {
                let (state, initError) = try await self.authenticator.initialize()
                if let error = initError {
                    callback(nil, error)
                    return
                }
                guard let state = state else {
                    callback(nil, SudoVirtualCardsSimulatorError.internalError(""))
                    return
                }
                if state != .signedIn {
                    let (signInResult, signInError) = try await self.authenticator.signIn(username: self.username, password: self.password)
                    if let error = signInError {
                        callback(nil, error)
                        return
                    }
                    guard signInResult != nil else {
                        callback(nil, SudoVirtualCardsSimulatorError.internalError(""))
                        return
                    }
                } else {
                    let (tokens, tokenError) = try await self.authenticator.getTokens()
                    if let error = tokenError {
                        callback(nil, error)
                        return
                    }
                    guard let token = tokens?.idToken?.tokenString else {
                        callback(nil, SudoVirtualCardsSimulatorError.internalError(""))
                        return
                    }
                    callback(token, nil)
                    return
                }
            } catch {
                callback(nil, error)
                return
            }
        }
    }
}
