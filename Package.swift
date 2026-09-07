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
        .library(name: "Radix", targets: ["Radix"]),
        .library(name: "Radix Standard Library Integration", targets: ["Radix Standard Library Integration"]),
        .library(name: "Radix Foundation Library Integration", targets: ["Radix Foundation Library Integration"]),
        .library(name: "Radix Test Support", targets: ["Radix Test Support"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Radix",
            dependencies: [
            ],
            path: "Sources/Radix"
        ),
        .target(
            name: "Radix Standard Library Integration",
            dependencies: [
                .target(name: "Radix"),
            ],
            path: "Sources/Radix Standard Library Integration"
        ),
        .target(
            name: "Radix Foundation Library Integration",
            dependencies: [
                .target(name: "Radix"),
                .target(name: "Radix Standard Library Integration"),
            ],
            path: "Sources/Radix Foundation Library Integration"
        ),
        .target(
            name: "Radix Test Support",
            dependencies: [
                .target(name: "Radix"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Radix Tests",
            dependencies: [
                .target(name: "Radix"),
                .target(name: "Radix Test Support"),
                .target(name: "Radix Standard Library Integration"),
                .target(name: "Radix Foundation Library Integration"),
            ],
            path: "Tests/Radix Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
