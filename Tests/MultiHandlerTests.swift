@testable import Senna
import XCTest

final class MultiHandlerTests: XCTestCase {
    func testMultiHandler() throws {
        var logger = Logger(label: "Multi") {
            MultiplexLogHandler([
                Handler(name: $0, sink: StandardSink.out(flushMode: .when(.warning)), formation: Formation.standard, logLevel: .trace),
                Handler(name: $0, sink: StandardSink.error(flushMode: .always), formation: Formation.standardXcode, logLevel: .notice),
            ])
        }
        logger.trace("\(UInt8.random(in: .min ..< .max))")
        logger.debug("\(UInt8.random(in: .min ..< .max))")
        logger.info("\(UInt8.random(in: .min ..< .max))")
        logger.notice("\(UInt8.random(in: .min ..< .max))")
        logger.warning("\(UInt8.random(in: .min ..< .max))")
        logger.error("\(UInt8.random(in: .min ..< .max))")
        logger.critical("\(UInt8.random(in: .min ..< .max))")
        logger.logLevel = .error
        logger.warning("\(UInt8.random(in: .min ..< .max))")
        logger.error("\(UInt8.random(in: .min ..< .max))")
    }
}
