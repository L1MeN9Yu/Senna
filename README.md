# Senna

**a logging engine backend of Apple's** [swift-log](https://github.com/apple/swift-log)

## Features

* Pure Swift
* Backend of `apple/swift-log`
* Both Darwin(iOS macOS watchOS tcOS) and Linux compatibility
* Builtin output target : `[stdout/stderr,file,oslog,syslog]`
* ANSI escape code
* Complete customizable for text out
* 100% Code Coverage

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/L1MeN9Yu/Senna.git", from: "2.4.0")
]
```

## Status

![Swift5.0+](https://img.shields.io/badge/Swift-5.0%2B-orange.svg?style=flat)
[![release](https://img.shields.io/github/v/release/L1MeN9Yu/Senna.svg?color=blue)](https://github.com/L1MeN9Yu/Senna/releases)
[![Build](https://github.com/L1MeN9Yu/Senna/actions/workflows/Build.yml/badge.svg)](https://github.com/L1MeN9Yu/Senna/actions/workflows/Build.yml)
[![codecov](https://codecov.io/gh/L1MeN9Yu/Senna/branch/main/graph/badge.svg?token=0ZQSVH4ERX)](https://codecov.io/gh/L1MeN9Yu/Senna)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/L1MeN9Yu/Senna/blob/main/LICENSE)

[![platforms](https://img.shields.io/badge/Platforms-macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-orange.svg?style=flat)](https://github.com/L1MeN9Yu/Senna/blob/main/Package.swift)

## Credit

* [swift-log](https://github.com/apple/swift-log)
* [swift-log-format-and-pipe](https://github.com/Adorkable/swift-log-format-and-pipe)
* [spdlog](https://github.com/gabime/spdlog)
* [Rainbow](https://github.com/onevcat/Rainbow)

## License

Senna is available under the [MIT license](http://www.opensource.org/licenses/mit-license). See the LICENSE file for details.

## Thanks | 鸣谢

Thanks to [JetBrains][JetBrains] for "Licenses for Open Source Development". [JetBrains][JetBrains] supports non-commercial open source projects by providing core project contributors with a set of best-in-class
developer tools free of charge.

感谢 [JetBrains][JetBrains] 提供的开源开发许可证。[JetBrains][JetBrains] 通过为项目核心开发者免费提供开发工具来支持非商业开源项目。

[JetBrains]: https://www.jetbrains.com/?from=Senna
