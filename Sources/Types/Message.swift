//
// Created by Mengyu Li on 2022/3/1.
//

public struct Message: ExpressibleByStringInterpolation, ExpressibleByStringLiteral {
    public private(set) var interpolation: Interpolation

    public init(stringLiteral value: String) {
        interpolation = Interpolation()
        interpolation.appendLiteral(value)
    }

    public init(stringInterpolation: Interpolation) {
        interpolation = stringInterpolation
    }
}

extension Message: CustomStringConvertible {
    public var description: String {
        interpolation.storage.reduce("") {
            switch $1 {
            case let .literal(value):
                return $0.appending(value)
            case let .string(value, privacy: privacy):
                return $0.appending(privacy.value(for: value()))
            case let .convertible(value, privacy: privacy):
                return $0.appending(privacy.value(for: value().description))
            case let .signedInt(value, format: format, privacy: privacy):
                switch format.format {
                case let .decimal(minDigits: minDigits, explicitPositiveSign: explicitPositiveSign):
                    let value = value()
                    let string = String(format: "\(explicitPositiveSign ? "+" : "")%0\(minDigits())ld", value)
                    return $0.appending(privacy.value(for: string))
                }
            case let .unsignedInt(value, format: format, privacy: privacy):
                switch format.format {
                case let .decimal(minDigits: minDigits, explicitPositiveSign: explicitPositiveSign):
                    let value = value()
                    let string = String(format: "\(explicitPositiveSign ? "+" : "")%0\(minDigits())lu", value)
                    return $0.appending(privacy.value(for: string))
                }
            case let .float(value, format: format, privacy: privacy):
                switch format.format {
                case let .fixed(precision, explicitPositiveSign):
                    let value = value()
                    let string = String(format: "\(explicitPositiveSign ? "+" : "")%.0\(precision())f", value)
                    return $0.appending(privacy.value(for: string))
                }
            #if canImport(CoreGraphics)
            case let .cgfloat(value, format: format, privacy: privacy):
                switch format.format {
                case let .fixed(precision, explicitPositiveSign):
                    let value = value()
                    let string = String(format: "\(explicitPositiveSign ? "+" : "")%.0\(precision())f", value)
                    return $0.appending(privacy.value(for: string))
                }
            #endif
            case let .double(value, format: format, privacy: privacy):
                switch format.format {
                case let .fixed(precision, explicitPositiveSign):
                    let value = value()
                    let string = String(format: "\(explicitPositiveSign ? "+" : "")%.0\(precision())f", value)
                    return $0.appending(privacy.value(for: string))
                }
            case let .bool(value, privacy: privacy):
                return $0.appending(privacy.value(for: value() ? "true" : "false"))
            #if canImport(ObjectiveC)
            case let .object(value, privacy: privacy):
                return $0.appending(privacy.value(for: value()))
            #endif
            case let .meta(value, privacy: privacy):
                return $0.appending(privacy.value(for: String(describing: value())))
            }
        }
    }
}
