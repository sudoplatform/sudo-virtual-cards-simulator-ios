//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync

/// Configuration for connecting to the Sudo VirtualCards Simulator Service via AppSync.
public struct SudoVirtualCardsSimulatorConfig: AWSAppSyncServiceConfigProvider, Decodable {

    // MARK: - Supplementary: Decodable

    enum CodingKeys: String, CodingKey {
        case endpoint = "apiUrl"
        case region
        case apiKey
        case poolId
        case clientId
        case clientDatabasePrefix
    }

    // MARK: - Properties

    /// User pool identitifer of the user pool being used for authentication.
    ///
     /// Only set this property if using authentication type `.amazonCognitoUserPools`.
    public var poolId: String?

    /// User pool client identifier of the user pool's client used for authentication.
    ///
    /// Only set this property if using authentication type `.amazonCognitoUserPools`.
    public var clientId: String?

    // MARK: - Properties: AWSAppSyncServiceConfigProvider

    public var endpoint: URL

    public var region: AWSRegionType

    public var clientDatabasePrefix: String?

    public var authType: AWSAppSyncAuthType

    public var apiKey: String?

    // MARK: - Lifecycle

    /// Initialize an instance of `SudoVirtualCardsSimulatorConfig`. Use this initializer if using `API_KEY` as the method of authentication.
    public init(
        endpoint: URL,
        region: AWSRegionType,
        apiKey: String,
        clientDatabasePrefix: String?
    ) {
        self.init(
            endpoint: endpoint,
            region: region,
            authType: .apiKey,
            poolId: nil,
            clientId: nil,
            apiKey: apiKey,
            clientDatabasePrefix: clientDatabasePrefix)
    }

    /// Initialize an instance of `SudoVirtualCardsSimulatorConfig`.  Use this initializer if using `AMAZON_COGNITO_USER_POOLS` as the method of authentication.
    public init(
        endpoint: URL,
        region: AWSRegionType,
        poolId: String,
        clientId: String,
        clientDatabasePrefix: String? = nil
    ) {
        self.init(
            endpoint: endpoint,
            region: region,
            authType: .amazonCognitoUserPools,
            poolId: poolId,
            clientId: clientId,
            apiKey: nil,
            clientDatabasePrefix: clientDatabasePrefix)
    }

    // MARK: - Lifecycle: Internal

    /// Initialize an instance of `SudoVirtualCardsSimulatorConfig`.
    init(
        endpoint: URL,
        region: AWSRegionType,
        authType: AWSAppSyncAuthType,
        poolId: String?,
        clientId: String?,
        apiKey: String?,
        clientDatabasePrefix: String?
    ) {
        self.endpoint = endpoint
        self.region = region
        self.authType = authType
        self.poolId = poolId
        self.clientId = clientId
        self.apiKey = apiKey
        self.clientDatabasePrefix = clientDatabasePrefix
    }

    // MARK: - Conformance: Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let endpoint = try container.decode(URL.self, forKey: .endpoint)
        let region = try container.decode(AWSRegionType.self, forKey: .region)
        let clientDatabasePrefix = try container.decodeIfPresent(String.self, forKey: .clientDatabasePrefix)

        if let apiKey = try container.decodeIfPresent(String.self, forKey: .apiKey) {
            self.init(
            endpoint: endpoint,
            region: region,
            authType: .apiKey,
            poolId: nil,
            clientId: nil,
            apiKey: apiKey,
            clientDatabasePrefix: clientDatabasePrefix)
        } else if
            let poolId = try container.decodeIfPresent(String.self, forKey: .poolId),
            let clientId = try container.decodeIfPresent(String.self, forKey: .clientId)
        {
            self.init(
            endpoint: endpoint,
            region: region,
            authType: .amazonCognitoUserPools,
            poolId: poolId,
            clientId: clientId,
            apiKey: nil,
            clientDatabasePrefix: clientDatabasePrefix)
        } else {
            let context = DecodingError.Context(
                codingPath: [
                    CodingKeys.apiKey,
                    CodingKeys.poolId,
                    CodingKeys.clientId
                ],
                debugDescription: "Authentication type not supported. Please include either api key credentials (apiKey) or cognito credentials"
                    + "(username, password, poolId, clientId)"
            )
            throw DecodingError.dataCorrupted(context)
        }
    }

}
