// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "ServiceModule",
    products: [
        .library(
            name: "ServiceModule",
            targets: ["ServiceModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
    ],
    targets: [
        .target(
            name: "ServiceModule",
            dependencies: [
                "Alamofire",
            ],
            resources: [
                .process("Resources/transactions.json")
            ]
        ),
        .testTarget(
            name: "ServiceModuleTests",
            dependencies: ["ServiceModule"]
        ),
    ]
)
