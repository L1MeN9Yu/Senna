//
// Created by Mengyu Li on 2022/3/1.
//

public struct IntegerFormatter {
    let format: Format

    init(format: Format) { self.format = format }
}

extension IntegerFormatter {
    enum Format {
        case decimal(minDigits: () -> Int, explicitPositiveSign: Bool)
    }
}

public extension IntegerFormatter {
    static var decimal: Self {
        decimal(explicitPositiveSign: false, minDigits: 0)
    }

    static func decimal(explicitPositiveSign: Bool = false) -> Self {
        decimal(explicitPositiveSign: explicitPositiveSign, minDigits: 0)
    }

    static func decimal(explicitPositiveSign: Bool = false, minDigits: @autoclosure @escaping () -> Int) -> Self {
        Self(format: .decimal(minDigits: minDigits, explicitPositiveSign: explicitPositiveSign))
    }
}
