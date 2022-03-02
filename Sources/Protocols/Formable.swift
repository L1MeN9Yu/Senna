//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation
import Logging

public protocol Formable {
    var components: [Component] { get }
    func format(name: String, level: Logger.Level, message: Logger.Message, prettyMetadata: String?, source: String, file: String, function: String, line: UInt) -> String
}

public extension Formable {
    // swiftlint:disable function_parameter_count
    func format(name: String, component: Component, date: Date, level: Logger.Level, message: Logger.Message, prettyMetadata: String?, source: String, file: String, function: String, line: UInt) -> String {
        switch component {
        case .name:
            return "<\(name)>"
        case let .timestamp(dateFormatter):
            return dateFormatter.string(from: date)
        case .level:
            return "\(level)"
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
