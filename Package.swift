// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "Senna",
        products: [
            // Products define the executables and libraries produced by a package, and make them visible to other packages.
            .library(name: "Senna", type: .dynamic, targets: ["Senna"]),
            .library(name: "SennaStatic", type: .static, targets: ["Senna"]),
        ],
        targets: [
            // Targets are the basic building blocks of a package. A target can define a module or a test suite.
            // Targets can depend on other targets in this package, and on products in packages which this package depends on.
            .target(
                    name: "Senna.spdlog",
                    cSettings: [CSetting.headerSearchPath("ExternalLibrary/include"), CSetting.unsafeFlags(["-IExternalLibrary/include"])],
                    cxxSettings: [CXXSetting.headerSearchPath("ExternalLibrary/include"), CXXSetting.unsafeFlags(["-IExternalLibrary/include"])]
            ),
            .target(name: "Senna", dependencies: ["Senna.spdlog"]),
            .testTarget(name: "SennaTests", dependencies: ["Senna"]),
        ],
        cxxLanguageStandard: .cxx14
)
