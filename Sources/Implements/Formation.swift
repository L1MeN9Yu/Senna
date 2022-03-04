//
// Created by Mengyu Li on 2020/8/12.
//

import Foundation
import Logging

public struct Formation: Formable {
    public let components: [Component]
    public let levelStyle: LevelStyle
    public let printer: Printable?
    public let separator: String?

    public init(components: [Component] = Component.defaultComponents, levelStyle: LevelStyle = .default, printer: Printable? = nil, separator: String? = " ") {
        self.components = components
        self.levelStyle = levelStyle
        self.printer = printer
        self.separator = separator
    }

    public func format(name: String, level: Logger.Level, message: Logger.Message, prettyMetadata: String?, source: String, file: String, function: String, line: UInt) -> String {
        components
            .map { component -> (Component, String) in
                let formatted = self.format(name: name, component: component, date: Date(), level: level, message: message, prettyMetadata: prettyMetadata, source: source, file: file, function: function, line: line)
                return (component, formatted)
            }
            .map { component, formatted -> (Component, String) in
                guard let emoji = printer?.emoji(for: level, component: component) else { return (component, formatted) }
                return (component, "\(emoji)")
            }
            .map { component, formatted -> String in
                var codes: [UInt8] = []
                if let textColor = printer?.textColor(for: level, component: component) {
                    codes.append(contentsOf: Style.textColor)
                    codes.append(contentsOf: textColor.value)
                }
                if let backgroundColor = printer?.backgroundColor(for: level, component: component) {
                    codes.append(contentsOf: Style.backgroundColor)
                    codes.append(contentsOf: backgroundColor.value)
                }
                if let styles = printer?.styles(for: level, component: component) {
                    codes.append(contentsOf: styles.value)
                }
                guard !codes.isEmpty else { return formatted }
                return "\(ControlCode.CSI)\(codes.map { String($0) }.joined(separator: ";"))m\(formatted)\(ControlCode.CSI)0m"
            }
            .filter { !$0.isEmpty }
            .joined(separator: separator ?? "")
    }
}

public extension Formation {
    static var standard: Self {
        Formation(
            components: [
                .name,
                .timestamp(Component.defaultDateFormatter),
                .level,
                .group([
                    .file,
                    .text(":"),
                    .line,
                ]),
                .function,
                .message,
                .metadata,
            ],
            printer: Printer.standard,
            separator: " ▶ "
        )
    }

    static var standardXcode: Self {
        Formation(
            components: [
                .name,
                .timestamp(Component.defaultDateFormatter),
                .level,
                .group([
                    .file,
                    .text(":"),
                    .line,
                ]),
                .function,
                .message,
                .metadata,
            ],
            printer: Printer.xcode,
            separator: " ▶ "
        )
    }

    static var file: Self {
        Formation(components: [
            .name,
            .timestamp(Component.defaultDateFormatter),
            .group([
                .level,
                .text(":"),
            ]),
            .message,
            .metadata,
        ])
    }

    static var os: Self {
        Formation(components: [
            .message,
            .metadata,
        ])
    }

    static var system: Self {
        Formation(components: [
            .message,
            .metadata,
        ])
    }
}
