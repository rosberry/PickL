// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PickL",
    platforms: [.iOS(.v12), .tvOS(.v12)],
    products: [
        .library(name: "PickL", targets: ["PickL"])
    ],
    targets: [
        .target(name: "PickL", path: "PickL/Sources"),
        .testTarget(name: "PickLTests", dependencies: ["PickL"], path: "PickL/Tests")
    ]
)
