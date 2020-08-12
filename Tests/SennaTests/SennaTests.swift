import Logging
@testable import Senna_
import XCTest

final class SennaTests: XCTestCase {
	func testExample() {
		var logger = Logger(label: "logger") { (_: String) -> LogHandler in
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

	static var allTests = [
		("testExample", testExample),
	]
}
