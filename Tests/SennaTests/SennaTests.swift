import XCTest
@testable import Senna

final class SennaTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        class Logger: Senna.Logger {
            let name: String = "Test"

            init() { self.register() }

            deinit { self.drop() }
        }

        let logger = Logger()
        logger.trace("trace")
        logger.debug("debug")
        logger.info("info")
        logger.warn("error")
        logger.error("error")
        logger.crit("crit")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
