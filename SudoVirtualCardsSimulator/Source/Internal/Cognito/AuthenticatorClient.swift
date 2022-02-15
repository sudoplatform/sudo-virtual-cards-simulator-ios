//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSMobileClient

/// Facade class for `AWSMobileClient`. Aids in testability.
protocol UserPoolAuthenticator {

    func initialize() async throws -> (UserState?, Error?)

    func signIn(username: String, password: String) async throws -> (SignInResult?, Error?)

    func getTokens() async throws -> (Tokens?, Error?)
}

/// Concrete class of `UserPoolAuthenticator`.
class AWSUserPoolAuthenticator: UserPoolAuthenticator {

    // MARK: - Properties

    var mobileClient: AWSMobileClient

    // MARK: - Lifecycle

    init(configuration: [String: Any]) {
        self.mobileClient = AWSMobileClient(configuration: configuration)
    }

    // MARK: - Conformance: UserPoolAuthenticator

    func initialize() async throws -> (UserState?, Error?) {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(result: UserState?, error: Error?), Error>) in
            mobileClient.initialize({ (result, error) in
                continuation.resume(returning: (result, error))
            })
        })
    }

    func signIn(username: String, password: String) async throws -> (SignInResult?, Error?) {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(result: SignInResult?, error: Error?), Error>) in
            mobileClient.signIn(username: username, password: password, completionHandler: { (result, error) in
                continuation.resume(returning: (result, error))
            })
        })
    }

    func getTokens() async throws -> (Tokens?, Error?) {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(result: Tokens?, error: Error?), Error>) in
            mobileClient.getTokens({ (result, error) in
                continuation.resume(returning: (result, error))
            })
        })
    }
}
