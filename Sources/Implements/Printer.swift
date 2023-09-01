//
// Created by Mengyu Li on 2020/8/20.
//

import Logging

public struct Printer: Printable {
    private let textColor: TextColorGeneration
    private let backgroundColor: BackgroundColorGeneration
    private let styles: StylesGeneration

    public init(textColor: @escaping TextColorGeneration, backgroundColor: @escaping BackgroundColorGeneration, styles: @escaping StylesGeneration) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.styles = styles
    }

    public func textColor(for level: Logger.Level, component: Component) -> EscapeCode? { textColor(level, component) }

    public func backgroundColor(for level: Logger.Level, component: Component) -> EscapeCode? { backgroundColor(level, component) }

    public func styles(for level: Logger.Level, component: Component) -> [Style]? { styles(level, component) }
}

public extension Printer {
    typealias TextColorGeneration = (Logger.Level, Component) -> EscapeCode?
    typealias BackgroundColorGeneration = (Logger.Level, Component) -> EscapeCode?
    typealias StylesGeneration = (Logger.Level, Component) -> [Style]?
}

public extension Printer {
    static let standard = Printer(
        textColor: {
            switch ($0, $1) {
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
        },
        backgroundColor: {
            switch ($0, $1) {
            case (.critical, .level), (.critical, .message):
                return criticalBackgroundColor
            default:
                return nil
            }
        },
        styles: {
            switch ($0, $1) {
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
    )

    static let xcode: Self? = nil

    static let legacy8bit = Printer(
        textColor: {
            switch ($0, $1) {
            case (.trace, .level), (.trace, .message):
                return traceText8Color
            case (.debug, .level), (.debug, .message):
                return debugText8Color
            case (.info, .level), (.info, .message):
                return infoText8Color
            case (.notice, .level), (.notice, .message):
                return noticeText8Color
            case (.warning, .level), (.warning, .message):
                return warningText8Color
            case (.error, .level), (.error, .message):
                return errorText8Color
            case (.critical, .level), (.critical, .message):
                return criticalText8Color
            default:
                return nil
            }
        },
        backgroundColor: {
            switch ($0, $1) {
            case (.critical, .level), (.critical, .message):
                return criticalBackground8Color
            default:
                return nil
            }
        },
        styles: {
            switch ($0, $1) {
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
    )

    static let legacy16bit = Printer(
        textColor: {
            switch ($0, $1) {
            case (.trace, .level), (.trace, .message):
                return traceText16Color
            case (.debug, .level), (.debug, .message):
                return debugText16Color
            case (.info, .level), (.info, .message):
                return infoText16Color
            case (.notice, .level), (.notice, .message):
                return noticeText16Color
            case (.warning, .level), (.warning, .message):
                return warningText16Color
            case (.error, .level), (.error, .message):
                return errorText16Color
            case (.critical, .level), (.critical, .message):
                return criticalText16Color
            default:
                return nil
            }
        },
        backgroundColor: {
            switch ($0, $1) {
            case (.critical, .level), (.critical, .message):
                return criticalBackground16Color
            default:
                return nil
            }
        },
        styles: {
            switch ($0, $1) {
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

// MARK: - Text 8bit Color

public extension Printer {
    static let traceText8Color = LegacyTextColor.lightGray
    static let debugText8Color = LegacyTextColor.green
    static let infoText8Color = LegacyTextColor.blue
    static let noticeText8Color = LegacyTextColor.magenta
    static let warningText8Color = LegacyTextColor.yellow
    static let errorText8Color = LegacyTextColor.red
    static let criticalText8Color = LegacyTextColor.lightGray
}

// MARK: - Text 16bit Color

public extension Printer {
    static let traceText16Color = LegacyTextColor.darkGray
    static let debugText16Color = LegacyTextColor.lightGreen
    static let infoText16Color = LegacyTextColor.lightBlue
    static let noticeText16Color = LegacyTextColor.lightMagenta
    static let warningText16Color = LegacyTextColor.lightYellow
    static let errorText16Color = LegacyTextColor.lightRed
    static let criticalText16Color = LegacyTextColor.white
}

// MARK: - Background Color

public extension Printer {
    static let criticalBackgroundColor = Color(red: 255, green: 0, blue: 0)
}

// MARK: - Background 8 Color

public extension Printer {
    static let criticalBackground8Color = LegacyBackgroundColor.red
}

// MARK: - Background 16 Color

public extension Printer {
    static let criticalBackground16Color = LegacyBackgroundColor.lightRed
}
