//
// Created by Mengyu Li on 2022/3/1.
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if canImport(ObjectiveC)
import ObjectiveC
#endif

public struct Interpolation: StringInterpolationProtocol {
    private(set) var storage: [Value] = []

    public init() {}

    public init(literalCapacity: Int, interpolationCount: Int) {}

    public mutating func appendLiteral(_ literal: String) {
        storage.append(.literal(literal))
    }
}

extension Interpolation {
    @usableFromInline
    enum Value {
        case literal(String)
        case string(() -> String, privacy: Privacy)
        case convertible(() -> CustomStringConvertible, privacy: Privacy)
        case signedInt(() -> Int64, format: IntegerFormatter, privacy: Privacy)
        case unsignedInt(() -> UInt64, format: IntegerFormatter, privacy: Privacy)
        case float(() -> Float, format: FloatFormatter, privacy: Privacy)
        #if canImport(CoreGraphics)
        case cgfloat(() -> CGFloat, format: FloatFormatter, privacy: Privacy)
        #endif
        case double(() -> Double, format: FloatFormatter, privacy: Privacy)
        case bool(() -> Bool, privacy: Privacy)
        #if canImport(ObjectiveC)
        case object(() -> NSObject, privacy: Privacy)
        #endif
        case meta(() -> Any.Type, privacy: Privacy)
    }
}

public extension Interpolation {
    /// Defines interpolation for expressions of type String.
    mutating func appendInterpolation(_ argumentString: @autoclosure @escaping () -> String, privacy: Privacy = .private) {
        storage.append(.string(argumentString, privacy: privacy))
    }

    /// Defines interpolation for values conforming to CustomStringConvertible. The values
    /// are displayed using the description methods on them.
    mutating func appendInterpolation<T>(_ value: @autoclosure @escaping () -> T, privacy: Privacy = .private) where T: CustomStringConvertible {
        storage.append(.convertible(value, privacy: privacy))
    }
}

public extension Interpolation {
    /// Defines interpolation for meta-types.
    mutating func appendInterpolation(_ value: @autoclosure @escaping () -> Any.Type, privacy: Privacy = .private) {
        storage.append(.meta(value, privacy: privacy))
    }

    #if canImport(ObjectiveC)
    /// Defines interpolation for expressions of type NSObject.
    mutating func appendInterpolation(_ argumentObject: @autoclosure @escaping () -> NSObject, privacy: Privacy = .private) {
        storage.append(.object(argumentObject, privacy: privacy))
    }
    #endif
}

public extension Interpolation {
    /// Defines interpolation for expressions of type Int
    mutating func appendInterpolation<T: SignedInteger>(_ number: @autoclosure @escaping () -> T, format: IntegerFormatter = .decimal, privacy: Privacy = .private) {
        storage.append(.signedInt({ Int64(number()) }, format: format, privacy: privacy))
    }

    /// Defines interpolation for expressions of type UInt
    mutating func appendInterpolation<T: UnsignedInteger>(_ number: @autoclosure @escaping () -> T, format: IntegerFormatter = .decimal, privacy: Privacy = .private) {
        storage.append(.unsignedInt({ UInt64(number()) }, format: format, privacy: privacy))
    }
}

public extension Interpolation {
    /// Defines interpolation for expressions of type Float
    mutating func appendInterpolation(_ number: @autoclosure @escaping () -> Float, format: FloatFormatter = .fixed, privacy: Privacy = .private) {
        storage.append(.float(number, format: format, privacy: privacy))
    }

    #if canImport(CoreGraphics)
    /// Defines interpolation for expressions of type CGFloat
    mutating func appendInterpolation(_ number: @autoclosure @escaping () -> CGFloat, format: FloatFormatter = .fixed, privacy: Privacy = .private) {
        storage.append(.cgfloat(number, format: format, privacy: privacy))
    }
    #endif

    /// Defines interpolation for expressions of type Double
    mutating func appendInterpolation(_ number: @autoclosure @escaping () -> Double, format: FloatFormatter = .fixed, privacy: Privacy = .private) {
        storage.append(.double(number, format: format, privacy: privacy))
    }
}

public extension Interpolation {
    /// Defines interpolation for expressions of type Bool
    mutating func appendInterpolation(_ boolean: @autoclosure @escaping () -> Bool, privacy: Privacy = .private) {
        storage.append(.bool(boolean, privacy: privacy))
    }
}
