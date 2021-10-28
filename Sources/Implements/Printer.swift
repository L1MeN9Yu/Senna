//
// Created by Mengyu Li on 2020/8/20.
//

import Logging

public struct Printer: Printable {
    private let emoji: EmojiGeneration
    private let textColor: TextColorGeneration
    private let backgroundColor: BackgroundColorGeneration
    private let styles: StylesGeneration

    public init(emoji: @escaping EmojiGeneration, textColor: @escaping TextColorGeneration, backgroundColor: @escaping BackgroundColorGeneration, styles: @escaping StylesGeneration) {
        self.emoji = emoji
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.styles = styles
    }

    public func emoji(for level: Logger.Level, component: Component) -> String? { emoji(level, component) }

    public func textColor(for level: Logger.Level, component: Component) -> Color? { textColor(level, component) }

    public func backgroundColor(for level: Logger.Level, component: Component) -> Color? { backgroundColor(level, component) }

    public func styles(for level: Logger.Level, component: Component) -> [Style]? { styles(level, component) }
}

public extension Printer {
    typealias EmojiGeneration = (Logger.Level, Component) -> String?
    typealias TextColorGeneration = (Logger.Level, Component) -> Color?
    typealias BackgroundColorGeneration = (Logger.Level, Component) -> Color?
    typealias StylesGeneration = (Logger.Level, Component) -> [Style]?
}

public extension Printer {
    static let `default` = Printer(
        emoji: { _, _ in nil },
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

    static let xcode = Printer(
        emoji: {
            switch ($0, $1) {
            case (.trace, .level):
                return "⚫️"
            case (.debug, .level):
                return "🟢"
            case (.info, .level):
                return "🔵"
            case (.notice, .level):
                return "🟣"
            case (.warning, .level):
                return "⚠️"
            case (.error, .level):
                return "❗️"
            case (.critical, .level):
                return "❌"
            default:
                return nil
            }
        },
        textColor: { _, _ in nil },
        backgroundColor: { _, _ in nil },
        styles: { _, _ in nil }
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
