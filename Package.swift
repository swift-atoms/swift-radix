// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-radix",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Radix Primitive",
            targets: ["Radix Primitive"]
        ),
        .library(
            name: "Radix",
            targets: ["Radix"]
        ),
        .library(
            name: "Radix Test Support",
            targets: ["Radix Test Support"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Radix Primitive",
            dependencies: []
        ),
        .target(
            name: "Radix",
            dependencies: [
                "Radix Primitive"
            ]
        ),
        .target(
            name: "Radix Test Support",
            dependencies: [
                "Radix"
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Radix Tests",
            dependencies: [
                "Radix",
                "Radix Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
