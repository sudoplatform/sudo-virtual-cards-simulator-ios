//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

// MARK: - @unchecked Sendable conformances for generated GraphQL types.
//
// The types in GraphQLAPI.swift are auto-generated and use `GraphQLMap` / `Snapshot`
// ([String: Any?]) as their backing store, which is not Sendable. These types are
// only used transiently within async methods and are never shared across isolation
// domains, so marking them @unchecked Sendable is safe in practice.

// MARK: - Request input structs

extension SimulateAuthorizationRequest: @unchecked Sendable {}
extension ExpiryInput: @unchecked Sendable {}
extension EnteredAddressInput: @unchecked Sendable {}
extension SimulateIncrementalAuthorizationRequest: @unchecked Sendable {}
extension SimulateReversalRequest: @unchecked Sendable {}
extension SimulateAuthorizationExpiryRequest: @unchecked Sendable {}
extension SimulateRefundRequest: @unchecked Sendable {}
extension SimulateDebitRequest: @unchecked Sendable {}

// MARK: - Query classes and nested types

extension ListSimulatorMerchantsQuery: @unchecked Sendable {}
extension ListSimulatorMerchantsQuery.Data: @unchecked Sendable {}
extension ListSimulatorMerchantsQuery.Data.ListSimulatorMerchant: @unchecked Sendable {}

extension ListSimulatorConversionRatesQuery: @unchecked Sendable {}
extension ListSimulatorConversionRatesQuery.Data: @unchecked Sendable {}
extension ListSimulatorConversionRatesQuery.Data.ListSimulatorConversionRate: @unchecked Sendable {}

// MARK: - Mutation classes and nested types

extension SimulateAuthorizationMutation: @unchecked Sendable {}
extension SimulateAuthorizationMutation.Data: @unchecked Sendable {}
extension SimulateAuthorizationMutation.Data.SimulateAuthorization: @unchecked Sendable {}
extension SimulateAuthorizationMutation.Data.SimulateAuthorization.BilledAmount: @unchecked Sendable {}

extension SimulateIncrementalAuthorizationMutation: @unchecked Sendable {}
extension SimulateIncrementalAuthorizationMutation.Data: @unchecked Sendable {}
extension SimulateIncrementalAuthorizationMutation.Data.SimulateIncrementalAuthorization: @unchecked Sendable {}
extension SimulateIncrementalAuthorizationMutation.Data.SimulateIncrementalAuthorization.BilledAmount: @unchecked Sendable {}

extension SimulateReversalMutation: @unchecked Sendable {}
extension SimulateReversalMutation.Data: @unchecked Sendable {}
extension SimulateReversalMutation.Data.SimulateReversal: @unchecked Sendable {}
extension SimulateReversalMutation.Data.SimulateReversal.BilledAmount: @unchecked Sendable {}

extension SimulateAuthorizationExpiryMutation: @unchecked Sendable {}
extension SimulateAuthorizationExpiryMutation.Data: @unchecked Sendable {}
extension SimulateAuthorizationExpiryMutation.Data.SimulateAuthorizationExpiry: @unchecked Sendable {}

extension SimulateRefundMutation: @unchecked Sendable {}
extension SimulateRefundMutation.Data: @unchecked Sendable {}
extension SimulateRefundMutation.Data.SimulateRefund: @unchecked Sendable {}
extension SimulateRefundMutation.Data.SimulateRefund.BilledAmount: @unchecked Sendable {}

extension SimulateDebitMutation: @unchecked Sendable {}
extension SimulateDebitMutation.Data: @unchecked Sendable {}
extension SimulateDebitMutation.Data.SimulateDebit: @unchecked Sendable {}
extension SimulateDebitMutation.Data.SimulateDebit.BilledAmount: @unchecked Sendable {}
