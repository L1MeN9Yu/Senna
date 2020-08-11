@testable import Senna
import XCTest

final class SennaTests: XCTestCase {
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.
		class Logger: Senna.Logger {
			let name: String = "Test"

			init() { register() }

			deinit { self.drop() }
		}

		let logger = Logger()
		logger.trace("trace")
		logger.debug("debug")
		logger.info("info")
		logger.warn("error")
		logger.error("error")
		logger.crit("crit")

		logger.info("senna version: \(Version.current)")
		logger.info("spdlog version: \(Version.spdlog)")
		logger.info("fmt version: \(Version.fmt)")
	}

	static var allTests = [
		("testExample", testExample),
	]
}
