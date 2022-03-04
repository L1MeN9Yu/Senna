//
// Created by Mengyu Li on 2022/3/4.
//

import Logging

public enum LevelStyle {
    // use default reflection metadata,the value depends your reflection-metadata of `-Xfrontend`configuration
    case `default`
    case firstCharacter
    case full
    case custom(transform: (Logger.Level) -> String)
}

extension Logger.Level {
    func output(of style: LevelStyle) -> String {
        switch style {
        case .default:
            return "\(self)"
        case .firstCharacter:
            switch self {
            case .trace:
                return "T"
            case .debug:
                return "D"
            case .info:
                return "I"
            case .notice:
                return "N"
            case .warning:
                return "W"
            case .error:
                return "E"
            case .critical:
                return "C"
            }
        case .full:
            switch self {
            case .trace:
                return "trace"
            case .debug:
                return "debug"
            case .info:
                return "info"
            case .notice:
                return "notice"
            case .warning:
                return "warning"
            case .error:
                return "error"
            case .critical:
                return "critical"
            }
        case let .custom(transform: transform):
            return transform(self)
        }
    }
}
