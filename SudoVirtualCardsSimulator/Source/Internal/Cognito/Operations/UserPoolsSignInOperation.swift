//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import SudoLogging
import AWSMobileClient

/// Operation for signing into a User Pool.
class UserPoolsSignInOperation: PlatformOperation {

    // MARK: - Properties

    /// AWS Mobile Client used to sign in.
    let authenticator: UserPoolAuthenticator

    /// Username used to authenticate.
    let username: String

    /// Password used to authenticate.
    let password: String

    /// Result of the operation. Will return the result of the sign in.
    ///
    /// This can be `nil` if the operation is unsuccessful.
    var result: SignInResult?

    // MARK: - Lifecycle

    /// Initialize an instance of `UserPoolsSignInOperation`.
    init(username: String, password: String, authenticator: UserPoolAuthenticator, logger: Logger) {
        self.username = username
        self.password = password
        self.authenticator = authenticator
        super.init(logger: logger)
    }

    // MARK: - PlatformOperation

    override func execute() {
        authenticator.signIn(username: username, password: password) { [weak self] signInResult, error in
            guard let weakSelf = self else { return }
            if let error = error {
                weakSelf.finishWithError(error)
                return
            }
            weakSelf.result = signInResult
            weakSelf.finish()
        }
    }
}
