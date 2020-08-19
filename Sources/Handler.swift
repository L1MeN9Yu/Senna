//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation
import Logging

public struct Handler: LogHandler {
	private var prettyMetadata: String?

	public let sinks: [Sink]
	public let formatter: Formable

	public var metadata = Logger.Metadata() {
		didSet { prettyMetadata = prettify(metadata) }
	}

	public var logLevel: Logger.Level

	public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
		get { metadata[metadataKey] }
		set { metadata[metadataKey] = newValue }
	}

	public init(sinks: [Sink], formatter: Formable, logLevel: Logger.Level) {
		self.sinks = sinks
		self.formatter = formatter
		self.logLevel = logLevel
	}

	public func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
		let prettyMetadata = metadata?.isEmpty ?? true
			? self.prettyMetadata
			: prettify(self.metadata.merging(metadata!, uniquingKeysWith: { _, new in new }))

		let formattedMessage = formatter.format(level: level, message: message, prettyMetadata: prettyMetadata, file: file, function: function, line: line)
		sinks.forEach { $0.process(formattedMessage) }
	}
}

extension Handler {
	private func prettify(_ metadata: Logger.Metadata) -> String? {
		!metadata.isEmpty ? metadata.map { "\($0)=\($1)" }.joined(separator: " ") : nil
	}
}
