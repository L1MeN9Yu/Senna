import Foundation
import Logging
@testable import Senna
import XCTest

final class SennaTests: XCTestCase {
	func testStandardOut() {
		var logger = Logger(label: "Standard") { (_: String) -> LogHandler in
			Handler(sink: Standard.out, formatter: Formatter.default, logLevel: .trace)
		}
		logger.trace("\(UInt8.max)")
		logger.debug("\(UInt8.max)")
		logger.info("\(UInt8.max)")
		logger.notice("\(UInt8.max)")
		logger.warning("\(UInt8.max)")
		logger.error("\(UInt8.max)")
		logger.critical("\(UInt8.max)")
		logger.logLevel = .error
		logger.info("Test info message")
	}

	func testFile() {
		let fileURL = URL(fileURLWithPath: "fileLog")
		var logger = Logger(label: "Standard") { (_: String) -> LogHandler in
			Handler(sink: File(fileURL), formatter: Formatter.default, logLevel: .trace)
		}

		var count = 500
		while count >= 0 {
			logger.trace("\(UInt8.max)")
			logger.debug("\(UInt8.max)")
			logger.info("\(UInt8.max)")
			logger.notice("\(UInt8.max)")
			logger.warning("\(UInt8.max)")
			logger.error("\(UInt8.max)")
			logger.critical("\(UInt8.max)")
			count -= 1
			Thread.sleep(forTimeInterval: 1)
		}

		logger.logLevel = .error
		logger.info("Test info message")
	}

	static var allTests = [
		("testExample", testStandardOut),
	]
}
