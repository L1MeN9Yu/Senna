//
// Created by Mengyu Li on 2020/8/20.
//

import Foundation
import Logging

public struct Printer: Printable {
    let textColor: (Logger.Level, Component) -> Color?
    let backgroundColor: (Logger.Level, Component) -> Color?
    let styles: (Logger.Level, Component) -> [Style]?

    public func textColor(for level: Logger.Level, component: Component) -> Color? { textColor(level, component) }

    public func backgroundColor(for level: Logger.Level, component: Component) -> Color? { backgroundColor(level, component) }

    public func styles(for level: Logger.Level, component: Component) -> [Style]? { styles(level, component) }
}

public extension Printer {
    static let `default` = Printer(
        textColor: { level, component in
            let color: () -> Color? = {
                switch (level, component) {
                case (.trace, .level), (.trace, .message):
                    return traceTextColor
                case (.debug, .level), (.debug, .message):
                    return debugTextColor
                case (.info, .level), (.info, .message):
                    return infoTextColor
                case (.notice, .level), (.notice, .message):
                    return noticeTextColor
                case (.warning, .level), (.warning, .message):
                    return warningTextColor
                case (.error, .level), (.error, .message):
                    return errorTextColor
                default:
                    return nil
                }
            }
            #if Xcode
            switch Self.forceColor {
            case false:
                return nil
            case true:
                return color()
            }
            #else
            return color()
            #endif
        },
        backgroundColor: { level, component in
            let color: () -> Color? = {
                switch (level, component) {
                case (.critical, .level), (.critical, .message):
                    return criticalBackgroundColor
                default:
                    return nil
                }
            }
            #if Xcode
            switch Self.forceColor {
            case false:
                return nil
            case true:
                return color()
            }
            #else
            return color()
            #endif
        },
        styles: { level, component in
            let style: () -> [Style]? = {
                switch (level, component) {
                case (.critical, .level), (.critical, .message):
                    return [.bold, .underline]
                case (.error, .level), (.error, .message):
                    return [.bold, .underline]
                case (.warning, .level), (.warning, .message):
                    return [.bold]
                default:
                    return nil
                }
            }
            #if Xcode
            switch Self.forceColor {
            case false:
                return nil
            case true:
                return style()
            }
            #else
            return style()
            #endif
        }
    )
}

// MARK: - Text Color

public extension Printer {
    static let traceTextColor = Color(red: 150, green: 150, blue: 150)
    static let debugTextColor = Color(red: 0, green: 255, blue: 127)
    static let infoTextColor = Color(red: 99, green: 184, blue: 255)
    static let noticeTextColor = Color(red: 205, green: 0, blue: 205)
    static let warningTextColor = Color(red: 255, green: 255, blue: 0)
    static let errorTextColor = Color(red: 255, green: 0, blue: 0)
}

// MARK: - Background Color

public extension Printer {
    static let criticalBackgroundColor = Color(red: 255, green: 0, blue: 0)
}

public extension Printer {
    static var forceColor: Bool {
        ProcessInfo.processInfo.environment["SennaColor"] == "1"
    }
}
