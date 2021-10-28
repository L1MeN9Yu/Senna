//
// Created by Mengyu Li on 2021/10/28.
//

@testable import Senna
import XCTest

final class StandardTests: XCTestCase {
    func testStandardOut() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: Standard.out, formatter: Formatter.standard, logLevel: .trace)
        }
        logger.trace("\(UInt8.max)")
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)")
    }

    func testStandardError() {
        let logger = Logger(label: "stderr") {
            Handler(name: $0, sink: Standard.error, formatter: Formatter.standard, logLevel: .trace)
        }
        logger.trace("\(UInt8.max)")
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)")
    }

    func testMetaData() {
        var logger = Logger(label: "stdout") {
            Handler(name: $0, sink: Standard.out, formatter: Formatter.standard, logLevel: .trace)
        }
        logger[metadataKey: "UserName"] = .string("L1MeN9Yu")
        logger[metadataKey: "UserID"] = .stringConvertible(9527)
        logger.trace("\(UInt8.max)", metadata: ["Key": .dictionary(["String": .stringConvertible(0)])])
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)", metadata: ["Key": .dictionary(["String": .stringConvertible(6)])])
    }

    func testLevel() {
        var logger = Logger(label: "stdout") {
            Handler(name: $0, sink: Standard.out, formatter: Formatter.standard, logLevel: .trace)
        }
        logger.trace("\(UInt8.max)")
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)")
        logger.logLevel = .critical
        logger.warning("will not log")
        logger.critical("will log")
    }

    func testStandardXcode() {
        let logger = Logger(label: "stdout+xcode") {
            Handler(name: $0, sink: Standard.out, formatter: Formatter.standardXcode, logLevel: .trace)
        }
        logger.trace("\(UInt8.max)")
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)")
    }
}
