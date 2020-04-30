// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import AWSAppSync

internal struct SimulateAuthorizationRequest: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(pan: String, amount: Int, merchantId: GraphQLID, billingAddress: Optional<EnteredAddressInput?> = nil, expiry: Optional<ExpiryInput?> = nil, csc: Optional<String?> = nil) {
    graphQLMap = ["pan": pan, "amount": amount, "merchantId": merchantId, "billingAddress": billingAddress, "expiry": expiry, "csc": csc]
  }

  internal var pan: String {
    get {
      return graphQLMap["pan"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "pan")
    }
  }

  internal var amount: Int {
    get {
      return graphQLMap["amount"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  internal var merchantId: GraphQLID {
    get {
      return graphQLMap["merchantId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "merchantId")
    }
  }

  internal var billingAddress: Optional<EnteredAddressInput?> {
    get {
      return graphQLMap["billingAddress"] as! Optional<EnteredAddressInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "billingAddress")
    }
  }

  internal var expiry: Optional<ExpiryInput?> {
    get {
      return graphQLMap["expiry"] as! Optional<ExpiryInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "expiry")
    }
  }

  internal var csc: Optional<String?> {
    get {
      return graphQLMap["csc"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "csc")
    }
  }
}

internal struct EnteredAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(addressLine1: Optional<String?> = nil, addressLine2: Optional<String?> = nil, city: Optional<String?> = nil, state: Optional<String?> = nil, postalCode: Optional<String?> = nil, country: Optional<String?> = nil) {
    graphQLMap = ["addressLine1": addressLine1, "addressLine2": addressLine2, "city": city, "state": state, "postalCode": postalCode, "country": country]
  }

  internal var addressLine1: Optional<String?> {
    get {
      return graphQLMap["addressLine1"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "addressLine1")
    }
  }

  internal var addressLine2: Optional<String?> {
    get {
      return graphQLMap["addressLine2"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "addressLine2")
    }
  }

  internal var city: Optional<String?> {
    get {
      return graphQLMap["city"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "city")
    }
  }

  internal var state: Optional<String?> {
    get {
      return graphQLMap["state"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }

  internal var postalCode: Optional<String?> {
    get {
      return graphQLMap["postalCode"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "postalCode")
    }
  }

  internal var country: Optional<String?> {
    get {
      return graphQLMap["country"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country")
    }
  }
}

internal struct ExpiryInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(mm: Int, yyyy: Int) {
    graphQLMap = ["mm": mm, "yyyy": yyyy]
  }

  internal var mm: Int {
    get {
      return graphQLMap["mm"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "mm")
    }
  }

  internal var yyyy: Int {
    get {
      return graphQLMap["yyyy"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "yyyy")
    }
  }
}

internal struct SimulateIncrementalAuthorizationRequest: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(amount: Int, authorizationId: GraphQLID) {
    graphQLMap = ["amount": amount, "authorizationId": authorizationId]
  }

  internal var amount: Int {
    get {
      return graphQLMap["amount"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  internal var authorizationId: GraphQLID {
    get {
      return graphQLMap["authorizationId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "authorizationId")
    }
  }
}

internal struct SimulateReversalRequest: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(amount: Int, authorizationId: GraphQLID) {
    graphQLMap = ["amount": amount, "authorizationId": authorizationId]
  }

  internal var amount: Int {
    get {
      return graphQLMap["amount"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  internal var authorizationId: GraphQLID {
    get {
      return graphQLMap["authorizationId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "authorizationId")
    }
  }
}

internal struct SimulateRefundRequest: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(amount: Int, debitId: GraphQLID) {
    graphQLMap = ["amount": amount, "debitId": debitId]
  }

  internal var amount: Int {
    get {
      return graphQLMap["amount"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  internal var debitId: GraphQLID {
    get {
      return graphQLMap["debitId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "debitId")
    }
  }
}

internal struct SimulateDebitRequest: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(amount: Int, authorizationId: GraphQLID) {
    graphQLMap = ["amount": amount, "authorizationId": authorizationId]
  }

  internal var amount: Int {
    get {
      return graphQLMap["amount"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  internal var authorizationId: GraphQLID {
    get {
      return graphQLMap["authorizationId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "authorizationId")
    }
  }
}

internal final class ListSimulatorMerchantsQuery: GraphQLQuery {
  internal static let operationString =
    "query ListSimulatorMerchants {\n  listSimulatorMerchants {\n    __typename\n    id\n    name\n    mcc\n    city\n    state\n    postalCode\n    country\n    currency\n    declineAfterAuthorization\n    declineBeforeAuthorization\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listSimulatorMerchants", type: .nonNull(.list(.nonNull(.object(ListSimulatorMerchant.selections))))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listSimulatorMerchants: [ListSimulatorMerchant]) {
      self.init(snapshot: ["__typename": "Query", "listSimulatorMerchants": listSimulatorMerchants.map { $0.snapshot }])
    }

    internal var listSimulatorMerchants: [ListSimulatorMerchant] {
      get {
        return (snapshot["listSimulatorMerchants"] as! [Snapshot]).map { ListSimulatorMerchant(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "listSimulatorMerchants")
      }
    }

    internal struct ListSimulatorMerchant: GraphQLSelectionSet {
      internal static let possibleTypes = ["SimulatorMerchant"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("mcc", type: .nonNull(.scalar(String.self))),
        GraphQLField("city", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("postalCode", type: .nonNull(.scalar(String.self))),
        GraphQLField("country", type: .nonNull(.scalar(String.self))),
        GraphQLField("currency", type: .nonNull(.scalar(String.self))),
        GraphQLField("declineAfterAuthorization", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("declineBeforeAuthorization", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, name: String, mcc: String, city: String, state: String? = nil, postalCode: String, country: String, currency: String, declineAfterAuthorization: Bool, declineBeforeAuthorization: Bool, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SimulatorMerchant", "id": id, "name": name, "mcc": mcc, "city": city, "state": state, "postalCode": postalCode, "country": country, "currency": currency, "declineAfterAuthorization": declineAfterAuthorization, "declineBeforeAuthorization": declineBeforeAuthorization, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      internal var mcc: String {
        get {
          return snapshot["mcc"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "mcc")
        }
      }

      internal var city: String {
        get {
          return snapshot["city"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      internal var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var postalCode: String {
        get {
          return snapshot["postalCode"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "postalCode")
        }
      }

      internal var country: String {
        get {
          return snapshot["country"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "country")
        }
      }

      internal var currency: String {
        get {
          return snapshot["currency"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "currency")
        }
      }

      internal var declineAfterAuthorization: Bool {
        get {
          return snapshot["declineAfterAuthorization"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "declineAfterAuthorization")
        }
      }

      internal var declineBeforeAuthorization: Bool {
        get {
          return snapshot["declineBeforeAuthorization"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "declineBeforeAuthorization")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }
    }
  }
}

internal final class ListSimulatorConversionRatesQuery: GraphQLQuery {
  internal static let operationString =
    "query ListSimulatorConversionRates {\n  listSimulatorConversionRates {\n    __typename\n    currency\n    amount\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listSimulatorConversionRates", type: .nonNull(.list(.nonNull(.object(ListSimulatorConversionRate.selections))))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listSimulatorConversionRates: [ListSimulatorConversionRate]) {
      self.init(snapshot: ["__typename": "Query", "listSimulatorConversionRates": listSimulatorConversionRates.map { $0.snapshot }])
    }

    internal var listSimulatorConversionRates: [ListSimulatorConversionRate] {
      get {
        return (snapshot["listSimulatorConversionRates"] as! [Snapshot]).map { ListSimulatorConversionRate(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "listSimulatorConversionRates")
      }
    }

    internal struct ListSimulatorConversionRate: GraphQLSelectionSet {
      internal static let possibleTypes = ["CurrencyAmount"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("currency", type: .nonNull(.scalar(String.self))),
        GraphQLField("amount", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(currency: String, amount: Int) {
        self.init(snapshot: ["__typename": "CurrencyAmount", "currency": currency, "amount": amount])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var currency: String {
        get {
          return snapshot["currency"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "currency")
        }
      }

      internal var amount: Int {
        get {
          return snapshot["amount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "amount")
        }
      }
    }
  }
}

internal final class SimulateAuthorizationMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SimulateAuthorization($input: SimulateAuthorizationRequest!) {\n  simulateAuthorization(input: $input) {\n    __typename\n    id\n    approved\n    billed {\n      __typename\n      currency\n      amount\n    }\n    authorizationCode\n    declineReason\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal var input: SimulateAuthorizationRequest

  internal init(input: SimulateAuthorizationRequest) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("simulateAuthorization", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SimulateAuthorization.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(simulateAuthorization: SimulateAuthorization) {
      self.init(snapshot: ["__typename": "Mutation", "simulateAuthorization": simulateAuthorization.snapshot])
    }

    internal var simulateAuthorization: SimulateAuthorization {
      get {
        return SimulateAuthorization(snapshot: snapshot["simulateAuthorization"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "simulateAuthorization")
      }
    }

    internal struct SimulateAuthorization: GraphQLSelectionSet {
      internal static let possibleTypes = ["SimulateAuthorizationResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("approved", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("billed", type: .object(Billed.selections)),
        GraphQLField("authorizationCode", type: .scalar(String.self)),
        GraphQLField("declineReason", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, approved: Bool, billed: Billed? = nil, authorizationCode: String? = nil, declineReason: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SimulateAuthorizationResponse", "id": id, "approved": approved, "billed": billed.flatMap { $0.snapshot }, "authorizationCode": authorizationCode, "declineReason": declineReason, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var approved: Bool {
        get {
          return snapshot["approved"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "approved")
        }
      }

      internal var billed: Billed? {
        get {
          return (snapshot["billed"] as? Snapshot).flatMap { Billed(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "billed")
        }
      }

      internal var authorizationCode: String? {
        get {
          return snapshot["authorizationCode"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "authorizationCode")
        }
      }

      internal var declineReason: String? {
        get {
          return snapshot["declineReason"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "declineReason")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal struct Billed: GraphQLSelectionSet {
        internal static let possibleTypes = ["CurrencyAmount"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("currency", type: .nonNull(.scalar(String.self))),
          GraphQLField("amount", type: .nonNull(.scalar(Int.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(currency: String, amount: Int) {
          self.init(snapshot: ["__typename": "CurrencyAmount", "currency": currency, "amount": amount])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var currency: String {
          get {
            return snapshot["currency"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "currency")
          }
        }

        internal var amount: Int {
          get {
            return snapshot["amount"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "amount")
          }
        }
      }
    }
  }
}

internal final class SimulateIncrementalAuthorizationMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SimulateIncrementalAuthorization($input: SimulateIncrementalAuthorizationRequest!) {\n  simulateIncrementalAuthorization(input: $input) {\n    __typename\n    id\n    approved\n    billed {\n      __typename\n      currency\n      amount\n    }\n    authorizationCode\n    declineReason\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal var input: SimulateIncrementalAuthorizationRequest

  internal init(input: SimulateIncrementalAuthorizationRequest) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("simulateIncrementalAuthorization", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SimulateIncrementalAuthorization.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(simulateIncrementalAuthorization: SimulateIncrementalAuthorization) {
      self.init(snapshot: ["__typename": "Mutation", "simulateIncrementalAuthorization": simulateIncrementalAuthorization.snapshot])
    }

    internal var simulateIncrementalAuthorization: SimulateIncrementalAuthorization {
      get {
        return SimulateIncrementalAuthorization(snapshot: snapshot["simulateIncrementalAuthorization"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "simulateIncrementalAuthorization")
      }
    }

    internal struct SimulateIncrementalAuthorization: GraphQLSelectionSet {
      internal static let possibleTypes = ["SimulateAuthorizationResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("approved", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("billed", type: .object(Billed.selections)),
        GraphQLField("authorizationCode", type: .scalar(String.self)),
        GraphQLField("declineReason", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, approved: Bool, billed: Billed? = nil, authorizationCode: String? = nil, declineReason: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SimulateAuthorizationResponse", "id": id, "approved": approved, "billed": billed.flatMap { $0.snapshot }, "authorizationCode": authorizationCode, "declineReason": declineReason, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var approved: Bool {
        get {
          return snapshot["approved"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "approved")
        }
      }

      internal var billed: Billed? {
        get {
          return (snapshot["billed"] as? Snapshot).flatMap { Billed(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "billed")
        }
      }

      internal var authorizationCode: String? {
        get {
          return snapshot["authorizationCode"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "authorizationCode")
        }
      }

      internal var declineReason: String? {
        get {
          return snapshot["declineReason"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "declineReason")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal struct Billed: GraphQLSelectionSet {
        internal static let possibleTypes = ["CurrencyAmount"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("currency", type: .nonNull(.scalar(String.self))),
          GraphQLField("amount", type: .nonNull(.scalar(Int.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(currency: String, amount: Int) {
          self.init(snapshot: ["__typename": "CurrencyAmount", "currency": currency, "amount": amount])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var currency: String {
          get {
            return snapshot["currency"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "currency")
          }
        }

        internal var amount: Int {
          get {
            return snapshot["amount"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "amount")
          }
        }
      }
    }
  }
}

internal final class SimulateReversalMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SimulateReversal($input: SimulateReversalRequest!) {\n  simulateReversal(input: $input) {\n    __typename\n    id\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal var input: SimulateReversalRequest

  internal init(input: SimulateReversalRequest) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("simulateReversal", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SimulateReversal.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(simulateReversal: SimulateReversal) {
      self.init(snapshot: ["__typename": "Mutation", "simulateReversal": simulateReversal.snapshot])
    }

    internal var simulateReversal: SimulateReversal {
      get {
        return SimulateReversal(snapshot: snapshot["simulateReversal"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "simulateReversal")
      }
    }

    internal struct SimulateReversal: GraphQLSelectionSet {
      internal static let possibleTypes = ["SimulateReversalResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SimulateReversalResponse", "id": id, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }
    }
  }
}

internal final class SimulateRefundMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SimulateRefund($input: SimulateRefundRequest!) {\n  simulateRefund(input: $input) {\n    __typename\n    id\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal var input: SimulateRefundRequest

  internal init(input: SimulateRefundRequest) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("simulateRefund", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SimulateRefund.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(simulateRefund: SimulateRefund) {
      self.init(snapshot: ["__typename": "Mutation", "simulateRefund": simulateRefund.snapshot])
    }

    internal var simulateRefund: SimulateRefund {
      get {
        return SimulateRefund(snapshot: snapshot["simulateRefund"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "simulateRefund")
      }
    }

    internal struct SimulateRefund: GraphQLSelectionSet {
      internal static let possibleTypes = ["SimulateRefundResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SimulateRefundResponse", "id": id, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }
    }
  }
}

internal final class SimulateDebitMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SimulateDebit($input: SimulateDebitRequest!) {\n  simulateDebit(input: $input) {\n    __typename\n    id\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal var input: SimulateDebitRequest

  internal init(input: SimulateDebitRequest) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("simulateDebit", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SimulateDebit.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(simulateDebit: SimulateDebit) {
      self.init(snapshot: ["__typename": "Mutation", "simulateDebit": simulateDebit.snapshot])
    }

    internal var simulateDebit: SimulateDebit {
      get {
        return SimulateDebit(snapshot: snapshot["simulateDebit"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "simulateDebit")
      }
    }

    internal struct SimulateDebit: GraphQLSelectionSet {
      internal static let possibleTypes = ["SimulateDebitResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SimulateDebitResponse", "id": id, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }
    }
  }
}
