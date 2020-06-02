//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Decodable representation of the config file.
struct SudoConfigFile: Decodable {

    var adminConsoleProjectService: SudoVirtualCardsSimulatorConfig
}
