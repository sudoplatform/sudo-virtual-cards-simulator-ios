//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Client used to interface with the virtual cards service simulator.
///
/// This client allows you to simulate the use of a virtual card at merchants to generate transaction events. The simulator is only available in sandbox
/// environments.
///
/// It is recommended to code to this interface, rather than the implementation class (`DefaultSudoVirtualCardsSimulatorClient`) as the implementation class is
/// only meant to be used for initializing an instance of the client.
public protocol SudoVirtualCardsSimulatorClient: AnyObject {

    // MARK: - Mutations: Transactions

    /// Simulate an authorization transaction (`.pending`).
    ///
    /// This causes a pending transaction to appear on the card with the passed in `id`.
    ///
    /// - Parameters:
    ///   - input: Input used to configure the authorization.
    /// - Returns:
    ///   - Response data from the simulation request.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateAuthorizationWithInput(_ input: SimulateAuthorizationInput) async throws -> SimulateAuthorizationResponse

    /// Simulate an incremental authorization transaction (`.pending`).
    ///
    /// This will increment an authorization transaction to increase its amount.
    ///
    /// - Parameters:
    ///   - input: Input used to configure the incremental authorization.
    /// - Returns:
    ///   - Response data from the simulation request.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateIncrementalAuthorizationWithInput(
    _ input: SimulateIncrementalAuthorizationInput
    ) async throws -> SimulateAuthorizationResponse

    /// Simulate an authorization reversal transaction.
    ///
    /// Reversals do not generate a transaction the user can see, but will instead reverse an existing authorization (`.pending`) transaction. A reversal can
    /// be partial, which will cause the authorization transaction to be decremented by the input amount, or can be reversed the entire amount. If the entire
    /// amount is reversed, the authorization transaction record will be deleted.
    ///
    /// Reversals cannot exceed the total of the authorization, otherwise an error will be returned and no operation will be performed.
    ///
    /// - Parameters:
    ///   - input: Input used to configure the reversal.
    /// - Returns:
    ///   - Response data from the simulation request.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateReversalWithInput(_ input: SimulateReversalInput) async throws -> SimulateReversalResponse

    /// Simulate expory of a pending authorization expiry (`.pending`).
    ///
    /// This causes a pending transaction to expire as if reversed
    ///
    /// - Parameters:
    ///   - id: id of pending authorization to expire
    /// - Returns:
    ///   - Response data from the simulation request.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateAuthorizationExpiryWithId(_ id: String) async throws -> SimulateAuthorizationExpiryResponse

    /// Simulate a refund transaction (`.refund`).
    ///
    /// Simulating a refund will generate a refund transaction. Simulating a refund does not mutate any existing records, and instead generates a new refund
    /// transaction.
    ///
    /// Refunds can only be performed against a transaction that has already been previously debited (`.complete`). Debits can also be partially refunded, which
    /// will generate a new refund transaction record of the partially refunded amount.
    ///
    /// Refunds cannot exceed the total amount of a debit, otherwise an error will be returned and no operation will be performed.
    ///
    /// - Parameters:
    ///   - input: Input used to configure the refund.
    /// - Returns:
    ///   - Response data from the simulation request.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateRefundWithInput(_ input: SimulateRefundInput) async throws -> SimulateRefundResponse

    /// Simulate a debit transaction (`.complete`).
    ///
    /// Simulating a debit will generate a `.complete` transaction. Simulating a debit does not mutate any existing records, and instead generates a new debit
    /// transaction.
    ///
    /// Debits can only be performed against a transaction that has already been previously authorized (`.pending`). Authorizations can also be partially
    /// debited, which will generate a debit record of the partially debited amount.
    ///
    /// Debits **can** exceed the total amount of a authorization
    ///
    /// - Parameters:
    ///   - input: Input used to configure the refund.
    /// - Returns:
    ///   - Response data from the simulation request.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateDebitWithInput(_ input: SimulateDebitInput) async throws -> SimulateDebitResponse

    // MARK: - Queries

    /// Retrieve a list of supported simulated merchants.
    ///
    /// This method returns all the supported merchants available to perform transaction simulations.
    ///
    /// - Returns:
    ///   - Merchants supported by the simulator.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func getSimulatorMerchants() async throws -> [SimulatorMerchant]

    /// Retrieve a list of conversion rates of supported currencies.
    /// This method returns all the supported currency conversion rates used by the simulator.
    ///
    /// - Returns:
    ///   - Currency conversion rates used by the simulator.
    ///   - Throws:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func getSimulatorConversionRates() async throws -> [CurrencyAmount]
}
