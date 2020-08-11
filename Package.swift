// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Senna",
	platforms: [
		SupportedPlatform.iOS(.v10),
		SupportedPlatform.macOS(.v10_14),
	],
	products: [
		.library(name: "Senna", targets: ["Senna"]),
		.library(name: "Senna.Dynamic", type: .dynamic, targets: ["Senna"]),
		.library(name: "Senna.Static", type: .static, targets: ["Senna"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
	],
	targets: [
		.target(name: "Senna.spdlog"),
		.target(name: "Senna", dependencies: [
			"Senna.spdlog",
		]),
		.target(name: "Senna_", dependencies: [
			.product(name: "Logging", package: "swift-log"),
		]),
		.testTarget(name: "SennaTests", dependencies: ["Senna", "Senna_"]),
	],
	cxxLanguageStandard: .cxx14
)
