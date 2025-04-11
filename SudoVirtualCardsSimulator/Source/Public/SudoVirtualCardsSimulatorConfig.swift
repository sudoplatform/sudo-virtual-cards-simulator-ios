//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Configuration for connecting to the Sudo VirtualCards Simulator Service via AppSync.
public struct SudoVirtualCardsSimulatorConfig: Decodable {

    // MARK: - Supplementary: Decodable

    enum CodingKeys: String, CodingKey {
        case endpoint = "apiUrl"
        case region
        case apiKey
        case clientDatabasePrefix
    }

    // MARK: - Properties

    public let endpoint: String

    public let region: String

    public let apiKey: String

    public let clientDatabasePrefix: String?

    // MARK: - Lifecycle

    /// Initialize an instance of `SudoVirtualCardsSimulatorConfig`.
    public init(
        endpoint: String,
        region: String,
        apiKey: String,
        clientDatabasePrefix: String? = nil
    ) {
        self.endpoint = endpoint
        self.region = region
        self.apiKey = apiKey
        self.clientDatabasePrefix = clientDatabasePrefix
    }

    // MARK: - Conformance: Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let endpoint = try container.decode(String.self, forKey: .endpoint)
        let region = try container.decode(String.self, forKey: .region)
        let apiKey = try container.decode(String.self, forKey: .apiKey)
        let clientDatabasePrefix = try container.decodeIfPresent(String.self, forKey: .clientDatabasePrefix)
        self.init(endpoint: endpoint, region: region, apiKey: apiKey, clientDatabasePrefix: clientDatabasePrefix)
    }
}
