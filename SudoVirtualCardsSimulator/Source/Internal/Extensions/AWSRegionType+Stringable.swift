//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import AWSCore

extension AWSRegionType {

    /// Returns a `String` interpretation of `Self`.
    var string: String {
        switch self {
        case .USEast1:
            return "us-east-1"
        case .USEast2:
            return "us-east-2"
        case .USWest1:
            return "us-west-1"
        case .USWest2:
            return "us-west-2"
        case .APEast1:
            return "ap-east-1"
        case .APSouth1:
            return "ap-south-1"
        case .APNortheast1:
            return "ap-northeast-1"
        case .APNortheast2:
            return "ap-northeast-2"
        case .APSoutheast1:
            return "ap-southeast-1"
        case .APSoutheast2:
            return "ap-southeast-2"
        case .APSoutheast3:
            return "ap-southeast-3"
        case .CACentral1:
            return "ca-central-1"
        case .CNNorth1:
            return "cn-north-1"
        case .CNNorthWest1:
            return "cn-northwest-1"
        case .EUCentral1:
            return "eu-central-1"
        case .EUSouth1:
            return "eu-south-1"
        case .EUWest1:
            return "eu-west-1"
        case .EUWest2:
            return "eu-west-2"
        case .EUWest3:
            return "eu-west-3"
        case .EUNorth1:
            return "eu-north-1"
        case .MECentral1:
            return "me-central-1"
        case .MESouth1:
            return "me-south-1"
        case .SAEast1:
            return "sa-east-1"
        case .AFSouth1:
            return "af-south-1"
        case .USGovEast1:
            return "us-gov-east-1"
        case .USGovWest1:
            return "us-gov-west-1"
        case .Unknown:
            fallthrough
        @unknown default:
            return ""
        }
    }
}
