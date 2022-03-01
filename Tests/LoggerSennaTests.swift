//
// Created by Mengyu Li on 2022/3/1.
//

@testable import Senna
import XCTest

final class LoggerSennaTests: XCTestCase {
    func testLiteral() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let message: Message = "Literal Message"
        logger.senna.trace(message)
        logger.senna.debug(message)
        logger.senna.info(message)
        logger.senna.notice(message)
        logger.senna.warning(message)
        logger.senna.error(message)
        logger.senna.critical(message)
        XCTAssertEqual(message.description, "Literal Message")
    }

    func testPrivate() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let message: Message = "public message + private \(UInt8.random(in: .min ..< .max))"
        logger.senna.trace(message)
        logger.senna.debug(message)
        logger.senna.info(message)
        logger.senna.notice(message)
        logger.senna.warning(message)
        logger.senna.error(message)
        logger.senna.critical(message)
        XCTAssertEqual(message.description, "public message + private <hidden>")
    }

    func testPublic() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let userName = "L1MeN9Yu"
        let userID = 9527
        let message: Message = "public \(userName, privacy: .public) + private \(userID, privacy: .private)"
        logger.senna.trace(message)
        logger.senna.debug(message)
        logger.senna.info(message)
        logger.senna.notice(message)
        logger.senna.warning(message)
        logger.senna.error(message)
        logger.senna.critical(message)
        XCTAssertEqual(message.description, "public L1MeN9Yu + private <hidden>")
    }

    func testHashMask() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let userName = "L1MeN9Yu"
        let userID = 9527
        let message: Message = "public \(userName, privacy: .private(mask: .hash)) + private \(userID, privacy: .private(mask: .hash))"
        logger.senna.trace(message)
        logger.senna.debug(message)
        logger.senna.info(message)
        logger.senna.notice(message)
        logger.senna.warning(message)
        logger.senna.error(message)
        logger.senna.critical(message)
        XCTAssertEqual(message.description, "public \(String(describing: "L1MeN9Yu").hash) + private \(String(describing: userID).hash)")
    }

    func testCustomHidden() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let userName = "L1MeN9Yu"
        let userID = 9527
        let message: Message = "public \(userName, privacy: .public) + private \(userID, privacy: .private(hidden: "🚫"))"
        logger.senna.trace(message)
        logger.senna.debug(message)
        logger.senna.info(message)
        logger.senna.notice(message)
        logger.senna.warning(message)
        logger.senna.error(message)
        logger.senna.critical(message)
        XCTAssertEqual(message.description, "public L1MeN9Yu + private 🚫")
    }
}
