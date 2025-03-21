// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SudoVirtualCardsSimulator",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SudoVirtualCardsSimulator",
            targets: ["SudoVirtualCardsSimulator"])
    ],
    dependencies: [
        .package(url: "https://github.com/sudoplatform/sudo-api-client-ios", from: "12.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-logging-ios", from: "2.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-user-ios", from: "17.0.3"),
        .package(url: "https://github.com/aws-amplify/aws-sdk-ios-spm", exact: "2.36.7"),
        .package(url: "https://github.com/sudoplatform/aws-mobile-appsync-sdk-ios.git", exact: "3.7.2"),
    ],
    targets: [
        .target(
            name: "SudoVirtualCardsSimulator",
            dependencies: [
                .product(name: "AWSAppSync", package: "aws-mobile-appsync-sdk-ios"),
                .product(name: "AWSCore", package: "aws-sdk-ios-spm"),
                .product(name: "SudoApiClient", package: "sudo-api-client-ios"),
                .product(name: "SudoLogging", package: "sudo-logging-ios"),
                .product(name: "SudoUser", package: "sudo-user-ios"),
            ],
            path: "SudoVirtualCardsSimulator/")
    ]
)

