//
// Created by mengyu.li on 2023/9/1.
//

/// 8/16 background color
public enum LegacyBackgroundColor {
    case `default`

    // 8 bit
    case black
    case red
    case green
    case yellow
    case blue
    case magenta
    case cyan
    case lightGray

    // 16 bit
    case darkGray
    case lightRed
    case lightGreen
    case lightYellow
    case lightBlue
    case lightMagenta
    case lightCyan
    case white
}

extension LegacyBackgroundColor: EscapeCode {
    public var value: [UInt8] {
        switch self {
        case .default:
            return [49]
        case .black:
            return [40]
        case .red:
            return [41]
        case .green:
            return [42]
        case .yellow:
            return [43]
        case .blue:
            return [44]
        case .magenta:
            return [45]
        case .cyan:
            return [46]
        case .lightGray:
            return [47]
        case .darkGray:
            return [100]
        case .lightRed:
            return [101]
        case .lightGreen:
            return [102]
        case .lightYellow:
            return [103]
        case .lightBlue:
            return [104]
        case .lightMagenta:
            return [105]
        case .lightCyan:
            return [106]
        case .white:
            return [107]
        }
    }
}
