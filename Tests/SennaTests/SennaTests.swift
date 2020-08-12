import Logging
@testable import Senna_
import XCTest

final class SennaTests: XCTestCase {
	func testExample() {
		let logger = Logger(label: "logger") { (_: String) -> LogHandler in
			Handler(sink: Standard.error, formatter: Formatter.apple, logLevel: .trace)
		}
		logger.error("Test error message")
		logger.info("Test info message")
		logger.logLevel = .error
		logger.info("Test info message")
	}

	static var allTests = [
		("testExample", testExample),
	]
}
