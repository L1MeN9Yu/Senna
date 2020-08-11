//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation
import Logging

struct Handler: LogHandler {
	private var prettyMetadata: String?

	public var metadata = Logger.Metadata() {
		didSet { prettyMetadata = prettify(metadata) }
	}

	var logLevel: Logger.Level

	public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
		get { metadata[metadataKey] }
		set { metadata[metadataKey] = newValue }
	}
}

extension Handler {
	private func prettify(_ metadata: Logger.Metadata) -> String? {
		!metadata.isEmpty ? metadata.map { "\($0)=\($1)" }.joined(separator: " ") : nil
	}
}
