//
// Created by Mengyu Li on 2021/10/28.
//

@testable import Senna
import XCTest

final class SystemTests: XCTestCase {
    func testSystem() {
        let logger = Logger(label: "syslog") {
            Handler(name: $0, sink: System(), formatter: Formatter.os, logLevel: .trace)
        }
        logger.trace("\(UInt8.random(in: .min ..< .max))")
        logger.debug("\(UInt8.random(in: .min ..< .max))")
        logger.info("\(UInt8.random(in: .min ..< .max))")
        logger.notice("\(UInt8.random(in: .min ..< .max))")
        logger.warning("\(UInt8.random(in: .min ..< .max))")
        logger.error("\(UInt8.random(in: .min ..< .max))")
        logger.critical("\(UInt8.random(in: .min ..< .max))")
    }
}
