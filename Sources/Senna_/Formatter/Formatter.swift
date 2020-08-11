//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation
import Logging

public protocol Formatter {
	var dateFormatter: DateFormatter { get }

	func format(level: Logger.Level, message: Logger.Message, prettyMetadata: String?, file: String, function: String, line: UInt) -> String
}
