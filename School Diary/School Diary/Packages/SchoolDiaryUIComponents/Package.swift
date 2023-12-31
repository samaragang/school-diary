// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SchoolDiaryUIComponents",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SchoolDiaryUIComponents",
            targets: ["SchoolDiaryUIComponents"])
    ],
    dependencies: [
        .package(url: "https://github.com/sparrowcode/AlertKit", exact: "5.1.7"),
        .package(url: "https://github.com/SnapKit/SnapKit", exact: "5.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SchoolDiaryUIComponents", dependencies: ["AlertKit", "SnapKit"])
    ]
)
