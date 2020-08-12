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
		let now = Date()

		return components.map {
			self.format(
				component: $0, date: now, level: level, message: message, prettyMetadata: prettyMetadata,
				file: file, function: function, line: line
			)
		}.filter { !$0.isEmpty }.joined(separator: separator ?? "")
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
