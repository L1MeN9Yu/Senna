//
// Created by Mengyu Li on 2020/8/12.
//

import Foundation
import Logging

public struct Formatter: Formable {
    public let components: [Component]
    public let printable: Printable?
    public let separator: String?

    public init(components: [Component] = Component.defaultComponents, printable: Printable? = nil, separator: String? = " ") {
        self.components = components
        self.printable = printable
        self.separator = separator
    }

    public func format(name: String, level: Logger.Level, message: Logger.Message, prettyMetadata: String?,
                       file: String, function: String, line: UInt) -> String
    {
        components
            .map { component -> (Component, String) in
                let formatted = self.format(
                    name: name, component: component, date: Date(), level: level, message: message, prettyMetadata: prettyMetadata,
                    file: file, function: function, line: line
                )
                return (component, formatted)
            }
            .map { component, formatted -> (Component, String) in
                guard let emoji = printable?.emoji(for: level, component: component) else { return (component, formatted) }
                return (component, "\(emoji)")
            }
            .map { component, formatted -> String in
                var codes: [UInt8] = []
                if let textColor = printable?.textColor(for: level, component: component) {
                    codes.append(contentsOf: Style.textColor)
                    codes.append(contentsOf: textColor.value)
                }
                if let backgroundColor = printable?.backgroundColor(for: level, component: component) {
                    codes.append(contentsOf: Style.backgroundColor)
                    codes.append(contentsOf: backgroundColor.value)
                }
                if let styles = printable?.styles(for: level, component: component) {
                    codes.append(contentsOf: styles.value)
                }
                guard !codes.isEmpty else { return formatted }
                return "\(ControlCode.CSI)\(codes.map { String($0) }.joined(separator: ";"))m\(formatted)\(ControlCode.CSI)0m"
            }
            .filter { !$0.isEmpty }
            .joined(separator: separator ?? "")
    }
}

public extension Formatter {
    static let standard = Formatter(
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
        printable: Printer.default,
        separator: " ▶ "
    )

    static let file = Formatter(components: [
        .name,
        .timestamp(Component.defaultDateFormatter),
        .group([
            .level,
            .text(":"),
        ]),
        .message,
        .metadata,
    ])

    static let os = Formatter(components: [
        .message,
        .metadata,
    ])
}
