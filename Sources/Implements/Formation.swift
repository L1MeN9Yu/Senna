//
// Created by Mengyu Li on 2020/8/12.
//

import Foundation
import Logging

public struct Formation: Formable {
    public let components: [Component]
    public let levelStyle: LevelStyle
    public let dateFormatter: DateFormatter
    public let printer: Printable?
    public let separator: String?

    public init(components: [Component], levelStyle: LevelStyle = .default, dateFormatter: DateFormatter = Self.dateFormatter, printer: Printable? = nil, separator: String? = " ") {
        self.components = components
        self.levelStyle = levelStyle
        self.dateFormatter = dateFormatter
        self.printer = printer
        self.separator = separator
    }

    public func format(name: String, level: Logger.Level, message: Logger.Message, prettyMetadata: String?, source: String, file: String, function: String, line: UInt) -> String {
        components
            .map { component -> (Component, String) in
                let formatted = self.format(name: name, component: component, date: Date(), level: level, message: message, prettyMetadata: prettyMetadata, source: source, file: file, function: function, line: line)
                return (component, formatted)
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

private extension Formation {
    // swiftlint:disable function_parameter_count
    func format(name: String, component: Component, date: Date, level: Logger.Level, message: Logger.Message, prettyMetadata: String?, source: String, file: String, function: String, line: UInt) -> String {
        switch component {
        case .name:
            return "<\(name)>"
        case .timestamp:
            return dateFormatter.string(from: date)
        case .level:
            return level.output(of: levelStyle)
        case .message:
            return "\(message)"
        case .metadata:
            return "\(prettyMetadata.map { "\($0)" } ?? "")"
        case .source:
            return "\(source)"
        case .file:
            return "\(URL(fileURLWithPath: file).lastPathComponent)"
        case .function:
            return "\(function)"
        case .line:
            return "\(line)"
        case let .text(value):
            return value
        case let .group(components):
            return components.map {
                format(name: name, component: $0, date: date, level: level, message: message, prettyMetadata: prettyMetadata, source: source, file: file, function: function, line: line)
            }
            .joined()
        }
    }

    // swiftlint:enable function_parameter_count
}

public extension Formation {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter
    }()
}

public extension Formation {
    static var standard: Self {
        Formation(
            components: [
                .name,
                .timestamp,
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
                .timestamp,
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
            levelStyle: .custom {
                switch $0 {
                case .trace:
                    return "🟤"
                case .debug:
                    return "🟢"
                case .info:
                    return "🔵"
                case .notice:
                    return "🟣"
                case .warning:
                    return "🟡️"
                case .error:
                    return "❗️"
                case .critical:
                    return "❌"
                }
            },
            printer: Printer.xcode,
            separator: " ▶ "
        )
    }

    static var file: Self {
        Formation(components: [
            .name,
            .timestamp,
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

    #if os(Linux)
    static var system: Self {
        Formation(components: [
            .message,
            .metadata,
        ])
    }
    #endif
}
