// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "Feature",
    products: [
        .library(
            name: "Feature",
            targets: ["Feature"]),
    ],
    dependencies: [
        .package(path: "../ServiceModule"),
        .package(path: "../UIModule"),
        .package(path: "../Utils")
    ],
    targets: [
        .target(
            name: "Feature",
            dependencies: ["ServiceModule", "Utils", "UIModule"]),
        .testTarget(
            name: "FeatureTests",
            dependencies: ["Feature"]
        ),
    ]
)
