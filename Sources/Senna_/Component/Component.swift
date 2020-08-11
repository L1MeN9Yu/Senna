//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation

public enum Component {
	/// Timestamp of log
	/// Specifying your timestamp format can be done by providing a DateFormatter through `Formatter.timestampFormatter`
	case timestamp

	/// Log level
	case level
	/// The actual message
	case message
	/// Log metadata
	case metadata
	/// The log's originating file
	case file
	/// The log's originating function
	case function
	/// The log's originating line number
	case line

	/// Literal text
	case text(String)
	/// A group of `LogComponents`, not using the specified `separator`
	case group([Component])

	public static var metaComponents: [Component] {
		[
			.timestamp,
			.level,
			.message,
			.metadata,
			.file,
			.function,
			.line,
		]
	}
}
