//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSMobileClient

/// Facade class for `AWSMobileClient`. Aids in testability.
protocol UserPoolAuthenticator {

    func initialize(_ completionHandler: @escaping (UserState?, Error?) -> Void)

    func signIn(username: String, password: String, completionHandler: @escaping ((SignInResult?, Error?) -> Void))

    func getTokens(_ completionHandler: @escaping (Tokens?, Error?) -> Void)
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

    func initialize(_ completionHandler: @escaping (UserState?, Error?) -> Void) {
        mobileClient.initialize(completionHandler)
    }

    func signIn(username: String, password: String, completionHandler: @escaping ((SignInResult?, Error?) -> Void)) {
        mobileClient.signIn(username: username, password: password, completionHandler: completionHandler)
    }

    func getTokens(_ completionHandler: @escaping (Tokens?, Error?) -> Void) {
        mobileClient.getTokens(completionHandler)
    }
}
