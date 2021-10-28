@testable import Senna
import XCTest

final class MultiHandlerTests: XCTestCase {
    func testMultiHandler() throws {
        var logger = Logger(label: "Multi") {
            MultiplexLogHandler([
                Handler(name: $0, sink: Standard.out, formatter: Formatter.standard, logLevel: .trace),
                Handler(name: $0, sink: Standard.error, formatter: Formatter.standardXcode, logLevel: .notice),
            ])
        }
        logger.trace("\(UInt8.max)")
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)")
        logger.logLevel = .error
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
    }
}
