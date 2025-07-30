// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "Utils",
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]),
    ],
    targets: [
        .target(
            name: "Utils"),
        .testTarget(
            name: "UtilsTests",
            dependencies: ["Utils"]
        ),
    ]
)
