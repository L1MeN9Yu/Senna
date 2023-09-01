//
// Created by mengyu.li on 2023/9/1.
//

/// 8/16 text color
public enum LegacyTextColor {
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

extension LegacyTextColor: EscapeCode {
    public var value: [UInt8] {
        switch self {
        case .default:
            return [39]
        case .black:
            return [30]
        case .red:
            return [31]
        case .green:
            return [32]
        case .yellow:
            return [33]
        case .blue:
            return [34]
        case .magenta:
            return [35]
        case .cyan:
            return [36]
        case .lightGray:
            return [37]
        case .darkGray:
            return [90]
        case .lightRed:
            return [91]
        case .lightGreen:
            return [92]
        case .lightYellow:
            return [93]
        case .lightBlue:
            return [94]
        case .lightMagenta:
            return [95]
        case .lightCyan:
            return [96]
        case .white:
            return [97]
        }
    }
}
