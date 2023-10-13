//
// Created by mengyu.li on 2023/10/12.
//

public struct Spacer {
    public let aligning: Aligning

    public init(aligning: @escaping Aligning) { self.aligning = aligning }
}

extension Spacer: Spacing {
    public func spacing(_ input: String, for component: Component) -> String {
        let align = aligning(component)
        switch align {
        case .raw:
            return input
        case let .left(truncate):
            switch input.count > truncate.max {
            case true:
                return truncate.truncate ? String(input.prefix(truncate.max)) : input
            case false:
                return input + String(repeating: " ", count: truncate.max - input.count)
            }
        case let .center(truncate):
            switch input.count > truncate.max {
            case true:
                return truncate.truncate ? String(input.prefix(truncate.max)) : input
            case false:
                let left = (truncate.max - input.count) / 2
                let right = truncate.max - input.count - left
                return String(repeating: " ", count: left) + input + String(repeating: " ", count: right)
            }
        case let .right(truncate):
            switch input.count > truncate.max {
            case true:
                return truncate.truncate ? String(input.suffix(truncate.max)) : input
            case false:
                return String(repeating: " ", count: truncate.max - input.count) + input
            }
        }
    }
}

public extension Spacer {
    typealias Aligning = (_ component: Component) -> Align

    enum Align {
        case raw
        case left(truncate: Truncate)
        case center(truncate: Truncate)
        case right(truncate: Truncate)
    }

    struct Truncate {
        public let max: Int
        public let truncate: Bool
    }
}
