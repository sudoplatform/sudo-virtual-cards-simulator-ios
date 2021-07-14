//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import AWSCore

/// Disables Cyclomatic Dependency for `AWSRegionType` as the kit has no control over `AWSRegionType`.
// swiftlint:disable cyclomatic_complexity

extension AWSRegionType {

    /// Initialize a `AWSRegionType` from a string interpretation. If the input `string` is unsupported, `nil` will be returned instead.
    init?(string: String) {
        switch string {
        case "us-east-1": self = .USEast1
        case "us-east-2": self = .USEast2
        case "us-west-1": self = .USWest1
        case "us-west-2": self = .USWest2
        case "ap-east-1": self = .APEast1
        case "ap-south-1": self = .APSouth1
        case "ap-northeast-1": self = .APNortheast1
        case "ap-northeast-2": self = .APNortheast2
        case "ap-southeast-1": self = .APSoutheast1
        case "ap-southeast-2": self = .APSoutheast2
        case "ca-central-1": self = .CACentral1
        case "cn-north-1": self = .CNNorth1
        case "cn-northwest-1": self = .CNNorthWest1
        case "eu-central-1": self = .EUCentral1
        case "eu-west-1": self = .EUWest1
        case "eu-west-2": self = .EUWest2
        case "eu-west-3": self = .EUWest3
        case "eu-north-1": self = .EUNorth1
        case "me-south-1": self = .MESouth1
        case "sa-east-1": self = .SAEast1
        case "us-gov-east-1": self = .USGovEast1
        case "us-gov-west-1": self = .USGovWest1
        default:
            return nil
        }
    }
}

extension AWSRegionType: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        guard let value = AWSRegionType.init(string: stringValue) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Value not supported: \(stringValue)")
        }
        self = value
    }
}
