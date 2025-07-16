// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WASM",
  platforms: [
    .iOS(.v18),
    .macOS(.v15),
  ],
  products: [
    .executable(name: "WASMDemo", targets: ["WASMDemo"])
  ],
  dependencies: [
    .package(
      path: "../../.."
    ),
    .package(
        url: "https://github.com/swiftwasm/JavaScriptKit.git",
        from: "0.31.1"
    ),
  ],
  targets: [
    .executableTarget(
      name: "WASMDemo",
      dependencies: [
        .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
        .product(name: "DefaultBackend", package: "swift-cross-ui"),
        .product(
            name: "JavaScriptKit",
            package: "JavaScriptKit",
        ),
        .product(
            name: "JavaScriptEventLoop",
            package: "JavaScriptKit",
        ),
      ],
      swiftSettings: [
        .defaultIsolation(MainActor.self)
      ],
    )
  ]
)
