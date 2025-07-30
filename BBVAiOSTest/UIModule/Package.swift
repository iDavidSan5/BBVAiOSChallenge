// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "UIModule",
    products: [
        .library(
            name: "UIModule",
            targets: ["UIModule"]),
    ],
    dependencies: [
        .package(path: "../Utils"),
        .package(path: "../ServiceModule"),
    ],
    targets: [
        .target(
            name: "UIModule",
            dependencies: ["ServiceModule", "Utils"]
        ),
        .testTarget(
            name: "UIModuleTests",
            dependencies: ["UIModule"]
        ),
    ]
)
