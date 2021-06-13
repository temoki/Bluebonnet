// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Bluebonnet",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
    ],
    products: [
        .library(name: "Bluebonnet", targets: ["Bluebonnet"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Bluebonnet", dependencies: []),
        .testTarget(name: "BluebonnetTests", dependencies: ["Bluebonnet"]),
    ]
)
