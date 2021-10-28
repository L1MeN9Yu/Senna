//
// Created by Mengyu Li on 2020/8/12.
//

/// https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
public enum Style: UInt8 {
    case normal = 0
    case bold = 1
    case dim = 2
    case italic = 3
    case underline = 4
    case blink = 5
    case reverse = 7
}

extension Style {
    static let textColor: [UInt8] = [38, 2]
    static let backgroundColor: [UInt8] = [48, 2]
}

extension Array: EscapeCode where Element == Style {
    public var value: [UInt8] {
        map(\.rawValue)
    }
}
