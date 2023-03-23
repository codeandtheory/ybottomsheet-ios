// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "YBottomSheet",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "YBottomSheet",
            targets: ["YBottomSheet"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/yml-org/YCoreUI.git",
            from: "1.5.0"
        ),
        .package(
            url: "https://github.com/yml-org/YMatterType.git",
            from: "1.6.0"
        )
    ],
    targets: [
        .target(
            name: "YBottomSheet",
            dependencies: ["YCoreUI", "YMatterType"]
        ),
        .testTarget(
            name: "YBottomSheetTests",
            dependencies: ["YBottomSheet"]
        )
    ]
)
