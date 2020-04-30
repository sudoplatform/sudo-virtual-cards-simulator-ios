//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoVirtualCards
import SudoOperations
import SudoUser
import SudoApiClient
import SudoLogging
import AWSAppSync

/// Default Client API Endpoint for interacting with the virtual cards service simulator.
public class DefaultSudoVirtualCardsSimulatorClient: SudoVirtualCardsSimulatorClient {

    // MARK: - Properties

    /// Operation Queue that all associated API operations are executed on.
    var queue = PlatformOperationQueue()

    /// Used for generating Operations internally.
    private let operationFactory: OperationFactory

    /// Used to make GraphQL requests to AWS. Injected into operations to delegate the calls.
    private let appSyncClient: AWSAppSyncClient

    /// Logging utility for debugging and diagnostics.
    private let logger: Logger

    // MARK: - Lifecycle

    /// Initialize a default Sudo virtual cards simulator instance.
    ///
    /// Currently, automatic API configuration is not supported for this service, so you are required to pass in the configuration. It is strongly recommended
    /// to use an APIKey auth type.
    ///
    /// - Parameter config: Configuration to establish connection with service.
    convenience public init(config: SudoVirtualCardsSimulatorConfig) throws {
        let appSyncConfig = try AWSAppSyncClientConfiguration(appSyncServiceConfig: config)
        let appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
        self.init(appSyncClient: appSyncClient)
    }

    /// Initialize a default virtual cards simulator instance. **This is intended purely for internal use only.**
    internal init(appSyncClient: AWSAppSyncClient, operationFactory: OperationFactory = OperationFactory(), logger: Logger = Logger.virtualCardsSDKLogger) {
        self.appSyncClient = appSyncClient
        self.operationFactory = operationFactory
        self.logger = logger
    }

    // MARK: - Methods

    public func reset() throws {
        logger.info("Resetting client state.")

        try self.appSyncClient.clearCaches(options: .init(clearQueries: true,
                                                          clearMutations: true, clearSubscriptions: true))
        queue.cancelAllOperations()
    }

    // MARK: - Mutations: Transactions

    public func simulateAuthorizationWithInput(_ input: SimulateAuthorizationInput, completion: @escaping ClientCompletion<SimulateAuthorizationResponse>) {
        var billingAddress: EnteredAddressInput?? = Optional(nil)
        if let inputAddress = input.billingAddress {
            billingAddress = .init(addressLine1: inputAddress.addressLine1,
                                   addressLine2: inputAddress.addressLine2,
                                   city: inputAddress.city,
                                   state: inputAddress.state,
                                   postalCode: inputAddress.postalCode,
                                   country: inputAddress.country)
        }
        guard let mm = Int(input.expiry.mm), let yyyy = Int(input.expiry.yyyy) else {
            logger.error("Expiry values expected Numbers that resolve to ints, instead got \(input.expiry)")
            return completion(.failure(SudoVirtualCardsSimulatorError.simulateAuthorizationFailed))
        }
        let expiry = ExpiryInput(mm: mm, yyyy: yyyy)
        var csc: String?? = Optional(nil)
        if let inputCSC = input.csc {
            csc = inputCSC
        }
        let request = SimulateAuthorizationRequest(
            pan: input.pan,
            amount: input.amount,
            merchantId: input.merchantId,
            billingAddress: billingAddress,
            expiry: expiry,
            csc: csc)
        let mutation = SimulateAuthorizationMutation(input: request)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.simulateAuthorization else {
                self?.logger.error("No result returned without error - this is unexpected behavior")
                completion(.failure(SudoVirtualCardsSimulatorError.simulateAuthorizationFailed))
                return
            }
            let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
            let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
            let response = SimulateAuthorizationResponse(
                id: result.id,
                approved: result.approved,
                createdAt: createdAt,
                updatedAt: updatedAt,
                declineReason: result.declineReason)
            completion(.success(response))
            return
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    public func simulateIncrementalAuthorizationWithInput(
        _ input: SimulateIncrementalAuthorizationInput,
        completion: @escaping ClientCompletion<SimulateAuthorizationResponse>
    ) {
        let input = SimulateIncrementalAuthorizationRequest(amount: input.amount,
                                                            authorizationId: input.authorizationId)
        let mutation = SimulateIncrementalAuthorizationMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation,
                                                                   appSyncClient: appSyncClient,
                                                                   logger: logger)
        let observer = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.simulateIncrementalAuthorization else {
                self?.logger.error("No result returned without error - this is unexpected behavior")
                completion(.failure(SudoVirtualCardsSimulatorError.simulateIncrementalAuthorizationFailed))
                return
            }
            let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
            let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
            let response = SimulateAuthorizationResponse(id: result.id,
                                                         approved: result.approved,
                                                         createdAt: createdAt,
                                                         updatedAt: updatedAt,
                                                         declineReason: result.declineReason)
            completion(.success(response))
            return
        })
        operation.addObserver(observer)
        queue.addOperation(operation)
    }

    public func simulateReversalWithInput(_ input: SimulateReversalInput, completion: @escaping ClientCompletion<SimulateReversalResponse>) {
        let input = SimulateReversalRequest(amount: input.amount, authorizationId: input.authorizationId)
        let mutation = SimulateReversalMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let observer = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.simulateReversal else {
                self?.logger.error("No result returned without error - this is unexpected behavior")
                completion(.failure(SudoVirtualCardsSimulatorError.simulateReversalFailed))
                return
            }
            let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
            let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
            let response = SimulateReversalResponse(id: result.id, createdAt: createdAt, updatedAt: updatedAt)
            completion(.success(response))
            return
        })
        operation.addObserver(observer)
        queue.addOperation(operation)
    }

    public func simulateRefundWithInput(_ input: SimulateRefundInput, completion: @escaping ClientCompletion<SimulateRefundResponse>) {
        let input = SimulateRefundRequest(amount: input.amount, debitId: input.debitId)
        let mutation = SimulateRefundMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let observer = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.simulateRefund else {
                self?.logger.error("No result returned without error - this is unexpected behavior")
                completion(.failure(SudoVirtualCardsSimulatorError.simulateRefundFailed))
                return
            }
            let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
            let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
            let response = SimulateRefundResponse(id: result.id, createdAt: createdAt, updatedAt: updatedAt)
            completion(.success(response))
            return
        })
        operation.addObserver(observer)
        queue.addOperation(operation)
    }

    public func simulateDebitWithInput(_ input: SimulateDebitInput, completion: @escaping ClientCompletion<SimulateDebitResponse>) {
        let input = SimulateDebitRequest(amount: input.amount, authorizationId: input.authorizationId)
        let mutation = SimulateDebitMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let observer = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.simulateDebit else {
                self?.logger.error("No result returned without error - this is unexpected behavior")
                completion(.failure(SudoVirtualCardsSimulatorError.simulateDebitFailed))
                return
            }
            let createdAt = Date(millisecondsSince1970: result.createdAtEpochMs)
            let updatedAt = Date(millisecondsSince1970: result.updatedAtEpochMs)
            let response = SimulateDebitResponse(id: result.id, createdAt: createdAt, updatedAt: updatedAt)
            completion(.success(response))
            return
        })
        operation.addObserver(observer)
        queue.addOperation(operation)
    }

    // MARK: - Queries

    public func getSimulatorMerchants(_ completion: @escaping ClientCompletion<[SimulatorMerchant]>) {
        let query = ListSimulatorMerchantsQuery()
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: .useOnline, logger: logger)
        let observer = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.listSimulatorMerchants else {
                self?.logger.error("No result returned without error - this is unexpected behavior")
                completion(.failure(SudoVirtualCardsSimulatorError.getSimulatorMerchantsFailed))
                return
            }
            let merchants: [SimulatorMerchant] = result.map {
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
                    updatedAt: updatedAt)
            }
            completion(.success(merchants))
            return
        })
        operation.addObserver(observer)
        queue.addOperation(operation)
    }

    public func getSimulatorConversionRates(_ completion: @escaping ClientCompletion<[CurrencyAmount]>) {
        let query = ListSimulatorConversionRatesQuery()
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: .useOnline, logger: logger)
        let observer = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.listSimulatorConversionRates else {
                self?.logger.error("No result returned without error - this is unexpected behavior")
                completion(.failure(SudoVirtualCardsSimulatorError.getSimulatorConversionRatesFailed))
                return
            }
            let conversionRates: [CurrencyAmount] = result.map {
                return CurrencyAmount(currency: $0.currency, amount: $0.amount)
            }
            completion(.success(conversionRates))
            return
        })
        operation.addObserver(observer)
        queue.addOperation(operation)
    }

}
