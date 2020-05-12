//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import SudoLogging

/// Operation for getting user id token from an authenticated session.
class UserPoolsGetTokenOperation: PlatformOperation {

    // MARK: - Properties

    /// AWS Mobile Client used to retrieve token.
    let authenticator: UserPoolAuthenticator

    /// Result of the operation. Will return the ID Token.
    ///
    /// This can be `nil` if the operation is unsuccessful.
    var result: String?

    // MARK: - Lifecycle

    /// Initialize an instance of `UserPoolsGetTokenOperation`.
    init(authenticator: UserPoolAuthenticator, logger: Logger) {
        self.authenticator = authenticator
        super.init(logger: logger)
    }

    // MARK: - PlatformOperation

    override func execute() {
        authenticator.getTokens { [weak self] tokens, error in
            guard let weakSelf = self else { return }
            if let error = error {
                weakSelf.finishWithError(error)
                return
            }
            weakSelf.result = tokens?.idToken?.tokenString
            weakSelf.finish()
        }
    }
}
