// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Senna",
    products: [
        .library(name: "Senna", targets: ["Senna"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
    ],
    targets: [
        .target(name: "Senna", dependencies: [
            .product(name: "Logging", package: "swift-log"),
        ], path: "Sources"),
        .testTarget(name: "SennaTests", dependencies: [
            .target(name: "Senna"),
        ], path: "Tests"),
    ]
)
