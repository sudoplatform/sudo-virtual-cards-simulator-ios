//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoUser
import SudoLogging

/// Default Client API Endpoint for interacting with the virtual cards service simulator.
public class DefaultSudoVirtualCardsSimulatorClient: SudoVirtualCardsSimulatorClient {
    
    // MARK: - Supplementary
    
    enum Defaults {
        static let configFileName = "sudoplatformconfig"
        static let configFileExtension = "json"
    }
    
    // MARK: - Properties
    
    /// Used to make GraphQL requests to AWS. Injected into operations to delegate the calls.
    private let graphQLClient: GraphQLClient
    
    /// Logging utility for debugging and diagnostics.
    private let logger: SudoLogging.Logger
    
    // MARK: - Lifecycle
    
    /// Initialize a default Sudo virtual cards simulator instance.
    ///
    /// This initializer will load configuration from the main bundle - please ensure you have a correctly configured configuration in sudoplatformconfig.json.
    public convenience init() throws {
        guard let configURL = Bundle.main.url(forResource: Defaults.configFileName, withExtension: Defaults.configFileExtension) else {
            Logger.virtualCardsSDKLogger.error("Failed to load config")
            throw SudoVirtualCardsSimulatorError.invalidConfig
        }
        let config: SudoVirtualCardsSimulatorConfig
        do {
            let fileData = try Data(contentsOf: configURL)
            let fileConfig = try JSONDecoder().decode(SudoConfigFile.self, from: fileData)
            config = fileConfig.vcSimulator
        } catch {
            Logger.virtualCardsSDKLogger.error("Error with config: \(error)")
            throw SudoVirtualCardsSimulatorError.invalidConfig
        }
        try self.init(config: config)
    }
    
    /// Initialize a default Sudo virtual cards simulator instance.
    ///
    /// - Parameter config: Configuration to establish connection with service.
    convenience public init(config: SudoVirtualCardsSimulatorConfig) throws {
        let graphQLClient = try DefaultGraphQLClient(
            apiName: "vcSimulator",
            endpoint: config.endpoint,
            region: config.region,
            apiKey: config.apiKey
        )
        self.init(graphQLClient: graphQLClient)
    }
    
    /// Initialize a default virtual cards simulator instance. **This is intended purely for internal use only.**
    init(graphQLClient: GraphQLClient, logger: SudoLogging.Logger = Logger.virtualCardsSDKLogger) {
        self.graphQLClient = graphQLClient
        self.logger = logger
    }
    
    // MARK: - Mutations: Transactions
    
    public func simulateAuthorizationWithInput(_ input: SimulateAuthorizationInput) async throws -> SimulateAuthorizationResponse {
        var billingAddress: EnteredAddressInput?? = Optional(nil)
        if let inputAddress = input.billingAddress {
            billingAddress = .init(
                addressLine1: inputAddress.addressLine1,
                addressLine2: inputAddress.addressLine2,
                city: inputAddress.city,
                state: inputAddress.state,
                postalCode: inputAddress.postalCode,
                country: inputAddress.country
            )
        }
        let expiry = ExpiryInput(mm: input.expiry.mm, yyyy: input.expiry.yyyy)
        var csc: String?? = Optional(nil)
        if let inputCSC = input.csc {
            csc = inputCSC
        }
        let request = SimulateAuthorizationRequest(
            pan: input.pan,
            amount: input.amount,
            merchantId: input.merchantId,
            expiry: expiry,
            billingAddress: billingAddress,
            csc: csc)
        let mutation = SimulateAuthorizationMutation(input: request)
        let data = try await graphQLClient.mutate(mutation)
        let result = data.simulateAuthorization
        let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
        let billedAmount =  CurrencyAmount(
            currency: result.billedAmount.currency,
            amount: result.billedAmount.amount)
        let response = SimulateAuthorizationResponse(
            id: result.id,
            approved: result.approved,
            billedAmount: billedAmount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            declineReason: result.declineReason
        )
        return response
    }
    
    public func simulateIncrementalAuthorizationWithInput(
        _ input: SimulateIncrementalAuthorizationInput
    ) async throws -> SimulateAuthorizationResponse {
        let input = SimulateIncrementalAuthorizationRequest(
            amount: input.amount,
            authorizationId: input.authorizationId
        )
        let mutation = SimulateIncrementalAuthorizationMutation(input: input)
        let data = try await graphQLClient.mutate(mutation)
        let result = data.simulateIncrementalAuthorization
        let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
        let billedAmount = CurrencyAmount(
            currency: result.billedAmount.currency,
            amount: result.billedAmount.amount
        )
        let response = SimulateAuthorizationResponse(
            id: result.id,
            approved: result.approved,
            billedAmount: billedAmount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            declineReason: result.declineReason
        )
        return response
    }
    
    public func simulateReversalWithInput(_ input: SimulateReversalInput) async throws -> SimulateReversalResponse {
        let input = SimulateReversalRequest(amount: input.amount, authorizationId: input.authorizationId)
        let mutation = SimulateReversalMutation(input: input)
        let data = try await graphQLClient.mutate(mutation)
        let result = data.simulateReversal
        let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
        let billedAmount =  CurrencyAmount(
            currency: result.billedAmount.currency,
            amount: result.billedAmount.amount)
        let response = SimulateReversalResponse(
            id: result.id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            billedAmount: billedAmount
        )
        return response
    }
    
    public func simulateAuthorizationExpiryWithId(_ id: String) async throws -> SimulateAuthorizationExpiryResponse {
        let input = SimulateAuthorizationExpiryRequest(authorizationId: id)
        let mutation = SimulateAuthorizationExpiryMutation(input: input)
        let data = try await graphQLClient.mutate(mutation)
        let result = data.simulateAuthorizationExpiry
        let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
        let response = SimulateAuthorizationExpiryResponse(
            id: result.id,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        return response
    }
    
    public func simulateRefundWithInput(_ input: SimulateRefundInput) async throws -> SimulateRefundResponse {
        let input = SimulateRefundRequest(amount: input.amount, debitId: input.debitId)
        let mutation = SimulateRefundMutation(input: input)
        let data = try await graphQLClient.mutate(mutation)
        let result = data.simulateRefund
        let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
        let billedAmount = CurrencyAmount(
            currency: result.billedAmount.currency,
            amount: result.billedAmount.amount)
        let response = SimulateRefundResponse(
            id: result.id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            billedAmount: billedAmount
        )
        return response
    }
    
    public func simulateDebitWithInput(_ input: SimulateDebitInput) async throws -> SimulateDebitResponse {
        let input = SimulateDebitRequest(amount: input.amount, authorizationId: input.authorizationId)
        let mutation = SimulateDebitMutation(input: input)
        let data = try await graphQLClient.mutate(mutation)
        let result = data.simulateDebit
        let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
        let billedAmount = CurrencyAmount(
            currency: result.billedAmount.currency,
            amount: result.billedAmount.amount)
        let response = SimulateDebitResponse(
            id: result.id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            billedAmount: billedAmount
        )
        return response
    }
    
    // MARK: - Queries
    
    public func getSimulatorMerchants() async throws -> [SimulatorMerchant] {
        let query = ListSimulatorMerchantsQuery()
        let data = try await graphQLClient.query(query)
        let merchants: [SimulatorMerchant] = data.listSimulatorMerchants.map {
            let createdAt = Date(millisecondsSince1970: $0.createdAtEpochMs)
            let updatedAt = Date(millisecondsSince1970: $0.updatedAtEpochMs)
            return SimulatorMerchant(
                id: $0.id,
                name: $0.name,
                mcc: $0.mcc,
                city: $0.city,
                state: $0.state,
                postalCode: $0.postalCode,
                country: $0.country,
                currency: $0.currency,
                declineAfterAuthorization: $0.declineAfterAuthorization,
                declineBeforeAuthorization: $0.declineBeforeAuthorization,
                createdAt: createdAt,
                updatedAt: updatedAt
            )
        }
        return merchants
    }
    
    public func getSimulatorConversionRates() async throws -> [CurrencyAmount] {
        let query = ListSimulatorConversionRatesQuery()
        let data = try await graphQLClient.query(query)
        let conversionRates: [CurrencyAmount] = data.listSimulatorConversionRates.map {
            return CurrencyAmount(currency: $0.currency, amount: $0.amount)
        }
        return conversionRates
    }
}
