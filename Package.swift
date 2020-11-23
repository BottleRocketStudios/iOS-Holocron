// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Holocron",
    platforms: [
        .macOS("10.12"),
        .iOS("10.0"),
        .tvOS("10.0"),
        .watchOS("4.2")
    ],
    products: [
        .library(
            name: "Holocron",
            targets: ["Holocron-iOS"])
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.1")
    ],
    targets: [
        .target(
            name: "Holocron-iOS",
            dependencies: ["KeychainAccess"],
            path: "Sources"),
        .testTarget(
            name: "Holocron-iOSTests",
            dependencies: ["Holocron-iOS"],
            path: "Tests")
    ]
)
