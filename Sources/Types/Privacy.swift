//
// Created by Mengyu Li on 2022/3/1.
//

public struct Privacy {
    public let isPrivate: Bool
    private let mask: Mask?
    private let hidden: String?

    init(isPrivate: Bool, mask: Mask?, hidden: String?) {
        self.isPrivate = isPrivate
        self.mask = mask
        self.hidden = hidden
    }
}

extension Privacy: Equatable {}

public extension Privacy {
    enum Mask: Equatable {
        case hash
        case none
    }
}

public extension Privacy {
    static var `public`: Self { Self(isPrivate: false, mask: nil, hidden: nil) }

    static var `private`: Self { Self(isPrivate: true, mask: nil, hidden: nil) }

    static func `private`(mask: Mask) -> Self { Self(isPrivate: true, mask: mask, hidden: nil) }

    static func `private`(hidden: String) -> Self { Self(isPrivate: true, mask: nil, hidden: hidden) }
}

private extension Privacy {
    static let hidden = "<hidden>"
}

extension Privacy {
    func value(for value: Any) -> String {
        switch self {
        case .public:
            return String(describing: value)
        case .private(mask: .hash):
            return "\(String(describing: value).hash)"
        default:
            return hidden ?? Self.hidden
        }
    }
}
