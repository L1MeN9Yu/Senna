//
// Created by Mengyu Li on 2022/3/1.
//

public struct FloatFormatter {
    let format: Format

    init(format: Format) { self.format = format }
}

extension FloatFormatter {
    enum Format {
        case fixed(precision: () -> Int, explicitPositiveSign: Bool)
    }
}

public extension FloatFormatter {
    static var fixed: Self {
        fixed(precision: 6, explicitPositiveSign: false)
    }

    static func fixed(explicitPositiveSign: Bool = false) -> Self {
        fixed(precision: 6, explicitPositiveSign: explicitPositiveSign)
    }

    static func fixed(precision: @autoclosure @escaping () -> Int, explicitPositiveSign: Bool = false) -> Self {
        Self(format: .fixed(precision: precision, explicitPositiveSign: explicitPositiveSign))
    }
}
