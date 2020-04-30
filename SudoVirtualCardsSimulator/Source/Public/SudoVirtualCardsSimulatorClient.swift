//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoVirtualCards

/// Generic type associated with API completion/closure handlers. Generic type O is the expected output result in a
/// success case.
public typealias ClientCompletion<O> = (Swift.Result<O, Error>) -> Void

/// Client used to interface with the virtual cards service simulator.
///
/// This client allows you to simulate the use of a virtual card at merchants to generate transaction events. The simulator is only available in sandbox
/// environments.
///
/// It is recommended to code to this interface, rather than the implementation class (`DefaultSudoVirtualCardsSimulatorClient`) as the implementation class is
/// only meant to be used for initializing an instance of the client.
public protocol SudoVirtualCardsSimulatorClient: class {

    // MARK: - Lifecycle

    /// Resets any cached data, and purges any pending operations.
    ///
    /// It is important to note that this will clear ALL cached data related to all
    /// sudo services.
    func reset() throws

    // MARK: - Mutations: Transactions

    /// Simulate an authorization transaction (`.pending`).
    ///
    /// This causes a pending transaction to appear on the card with the passed in `id`.
    ///
    /// - Parameters:
    ///   - input: Input used to configure the authorization.
    /// - Returns:
    ///   - Success: Response data from the simulation request.
    ///   - Failure:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateAuthorizationWithInput(_ input: SimulateAuthorizationInput, completion: @escaping ClientCompletion<SimulateAuthorizationResponse>)

    /// Simulate an incremental authorization transaction (`.pending`).
    ///
    /// This will increment an authorization transaction to increase its amount.
    ///
    /// - Parameters:
    ///   - input: Input used to configure the incremental authorization.
    /// - Returns:
    ///   - Success: Response data from the simulation request.
    ///   - Failure:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateIncrementalAuthorizationWithInput(
        _ input: SimulateIncrementalAuthorizationInput,
        completion: @escaping ClientCompletion<SimulateAuthorizationResponse>
    )

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
    ///   - Success: Response data from the simulation request.
    ///   - Failure:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateReversalWithInput(_ input: SimulateReversalInput, completion: @escaping ClientCompletion<SimulateReversalResponse>)

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
    ///   - Success: Response data from the simulation request.
    ///   - Failure:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateRefundWithInput(_ input: SimulateRefundInput, completion: @escaping ClientCompletion<SimulateRefundResponse>)

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
    ///   - Success: Response data from the simulation request.
    ///   - Failure:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func simulateDebitWithInput(_ input: SimulateDebitInput, completion: @escaping ClientCompletion<SimulateDebitResponse>)

    // MARK: - Queries

    /// Retrieve a list of supported simulated merchants.
    ///
    /// This method returns all the supported merchants available to perform transaction simulations. A list of these merchants can also be found
    /// [here](www.example.com/todo-add-link-to-merchants).
    ///
    /// - Returns:
    ///   - Success: Merchants supported by the simulator.
    ///   - Failure:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func getSimulatorMerchants(_ completion: @escaping ClientCompletion<[SimulatorMerchant]>)

    /// Retrieve a list of conversion rates of supported currencies.
    /// This method returns all the supported currency conversion rates used by the simulator. A list of these rates can also be found
    /// [here](www.example.com/todo-add-link-to-rates).
    ///
    /// - Returns:
    ///   - Success: Currency conversion rates used by the simulator.
    ///   - Failure:
    ///     - SudoPlatformError.
    ///     - SudoVirtualCardsSimulatorError.
    func getSimulatorConversionRates(_ completion: @escaping ClientCompletion<[CurrencyAmount]>)
}
