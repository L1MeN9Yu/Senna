//
// Created by Mengyu Li on 2020/8/12.
//

import Foundation
import Logging

public struct Formatter: Formable {
	public let components: [Component]

	public let separator: String?

	public init(components: [Component] = Component.defaultComponents, separator: String? = " ") {
		self.components = components
		self.separator = separator
	}

	public func format(
		level: Logger.Level, message: Logger.Message, prettyMetadata: String?,
		file: String, function: String, line: UInt
	) -> String {
		components
			.map { (component) -> (Component, String) in
				let formatted = self.format(
					component: component, date: Date(), level: level, message: message, prettyMetadata: prettyMetadata,
					file: file, function: function, line: line
				)
				return (component, formatted)
			}
			.map { (component, formatted) -> String in
				var codes: [UInt8] = []
				if let textColor = self.textColor(for: level, component: component) {
					codes.append(contentsOf: Style.textColor)
					codes.append(contentsOf: textColor.value)
				}
				if let backgroundColor = self.backgroundColor(for: level, component: component) {
					codes.append(contentsOf: Style.backgroundColor)
					codes.append(contentsOf: backgroundColor.value)
				}
				if let styles = self.styles(for: level, component: component) {
					codes.append(contentsOf: styles.value)
				}
				guard !codes.isEmpty else { return formatted }
				return "\(ControlCode.CSI)\(codes.map { String($0) }.joined(separator: ";"))m\(formatted)\(ControlCode.CSI)0m"
			}
			.filter { !$0.isEmpty }
			.joined(separator: separator ?? "")
	}
}

extension Formatter: Printable {
	public func textColor(for level: Logger.Level, component: Component) -> Color? {
		switch (level, component) {
		case (.error, .level), (.error, .message):
			return Color.errorText
		case (.warning, .level), (.warning, .message):
			return Color.warningText
		case (.notice, .level), (.notice, .message):
			return Color.noticeText
		case (.info, .level), (.info, .message):
			return Color.infoText
		case (.debug, .level), (.debug, .message):
			return Color.debugText
		case (.trace, .level), (.trace, .message):
			return Color.traceText
		default:
			return nil
		}
	}

	public func backgroundColor(for level: Logger.Level, component: Component) -> Color? {
		switch (level, component) {
		case (.critical, .level), (.critical, .message):
			return Color.criticalBackground
		default:
			return nil
		}
	}

	public func styles(for level: Logger.Level, component: Component) -> [Style]? {
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
}

public extension Formatter {
	static let `default` = Formatter(components: [
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
	], separator: " ▶ ")

	static let apple = Formatter(components: [
		.timestamp(Component.defaultDateFormatter),
		.group([
			.level,
			.text(":"),
		]),
		.message,
	])
}
