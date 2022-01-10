//
// Created by Mengyu Li on 2021/10/28.
//

#if os(Linux)

@testable import Senna
import XCTest

final class SystemLogSinkTests: XCTestCase {
    func testSystem() {
        let logger = Logger(label: "syslog") {
            Handler(name: $0, sink: SystemLogSink(), formation: Formation.system, logLevel: .trace)
        }
        logger.trace("\(UInt8.random(in: .min ..< .max))")
        logger.debug("\(UInt8.random(in: .min ..< .max))")
        logger.info("\(UInt8.random(in: .min ..< .max))")
        logger.notice("\(UInt8.random(in: .min ..< .max))")
        logger.warning("\(UInt8.random(in: .min ..< .max))")
        logger.error("\(UInt8.random(in: .min ..< .max))")
        logger.critical("\(UInt8.random(in: .min ..< .max))")
    }

    func testMetaData() {
        var logger = Logger(label: "syslog") {
            Handler(name: $0, sink: SystemLogSink(), formation: Formation.system, logLevel: .trace)
        }
        logger[metadataKey: "UserName"] = .string("L1MeN9Yu")
        logger[metadataKey: "UserID"] = .stringConvertible(9527)
        logger.trace("\(UInt8.random(in: .min ..< .max))", metadata: ["Key": .dictionary(["String": .stringConvertible(0)])])
        logger.debug("\(UInt8.random(in: .min ..< .max))")
        logger.info("\(UInt8.random(in: .min ..< .max))")
        logger.notice("\(UInt8.random(in: .min ..< .max))")
        logger.warning("\(UInt8.random(in: .min ..< .max))")
        logger.error("\(UInt8.random(in: .min ..< .max))")
        logger.critical("\(UInt8.random(in: .min ..< .max))", metadata: ["Key": .dictionary(["String": .stringConvertible(6)])])
    }
}
#endif
