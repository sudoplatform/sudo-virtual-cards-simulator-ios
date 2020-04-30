//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

import AWSAppSync

/// Configuration for connecting to the Sudo VirtualCards Simulator Service via AppSync.
public struct SudoVirtualCardsSimulatorConfig: AWSAppSyncServiceConfigProvider, Decodable {

    // MARK: - Properties: AWSAppSyncServiceConfigProvider

    public var endpoint: URL

    public var region: AWSRegionType

    public var authType: AWSAppSyncAuthType = .apiKey

    public var apiKey: String?

    public var clientDatabasePrefix: String?

    // MARK: - Lifecycle

    /// Initialize an instance of `SudoVirtualCardsSimulatorConfig`.
    public init(endpoint: URL, region: AWSRegionType, authType: AWSAppSyncAuthType = .apiKey, apiKey: String? = nil, clientDatabasePrefix: String? = nil) {
        self.endpoint = endpoint
        self.region = region
        self.authType = authType
        self.apiKey = apiKey
        self.clientDatabasePrefix = clientDatabasePrefix
    }

    // MARK: - Conformance: Decodable

    enum CodingKeys: String, CodingKey {
        case endpoint = "apiUrl"
        case region
        case authType = "authMode"
        case apiKey
        case clientDatabasePrefix
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let endpoint = try container.decode(URL.self, forKey: .endpoint)
        let region = try container.decode(AWSRegionType.self, forKey: .region)
        let authType = try container.decodeIfPresent(AWSAppSyncAuthType.self, forKey: .authType) ?? .apiKey
        let apiKey = try container.decodeIfPresent(String.self, forKey: .apiKey)
        let clientDatabasePrefix = try container.decodeIfPresent(String.self, forKey: .clientDatabasePrefix)
        self.init(endpoint: endpoint,
                  region: region,
                  authType: authType,
                  apiKey: apiKey,
                  clientDatabasePrefix: clientDatabasePrefix)
    }

}
