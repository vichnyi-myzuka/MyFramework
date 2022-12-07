// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyFramework",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MyFramework",
            targets: ["MyFramework"]),
    ],
    dependencies: [],
    targets: [        .target(
            name: "MyFramework",
            dependencies: []),
        .testTarget(
            name: "MyFrameworkTests",
            dependencies: ["MyFramework"]),
    ]
)
