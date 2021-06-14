// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Bluebonnet",
    platforms: [
        .iOS(.v10), .macOS(.v10_12)
    ],
    products: [
        .library(name: "Bluebonnet", targets: ["Bluebonnet"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "9.2.0"),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", from: "9.1.0"),
    ],
    targets: [
        .target(
            name: "Bluebonnet",
            dependencies: []
        ),
        .testTarget(
            name: "BluebonnetTests",
            dependencies: [
                "Bluebonnet",
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "OHHTTPStubs", package: "OHHTTPStubs"),
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs"),
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
