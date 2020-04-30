//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoLogging

internal extension Logger {

    /// Logger used internally in the SudoVirtualCards.
    static let virtualCardsSDKLogger = Logger(identifier: "SudoVirtualCardsSimulator", driver: NSLogDriver(level: .debug))
}
