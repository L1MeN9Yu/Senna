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

    func testValues() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let message: Message = """
        public message
        public sint \(Int(256), format: .decimal(explicitPositiveSign: true), privacy: .public))
        public sint \(Int(256), format: .decimal(explicitPositiveSign: true, minDigits: 6), privacy: .public))
        public uint \(UInt(256), format: .decimal, privacy: .public))
        public uint \(UInt(256), format: .decimal(explicitPositiveSign: true, minDigits: 6), privacy: .public))
        public double \(Double.pi, format: .fixed(precision: 6), privacy: .public)
        public double \(Double.pi, format: .fixed(precision: 6, explicitPositiveSign: true), privacy: .public)
        public float \(Float(Double.pi), format: .fixed, privacy: .public)
        public float \(Float(Double.pi), format: .fixed(explicitPositiveSign: true), privacy: .public)
        public bool \(true, privacy: .public)
        public bool \(false, privacy: .public)
        public meta \(Logger.self, privacy: .public)
        """
        logger.senna.log(level: .trace, message: message)
        logger.senna.log(level: .debug, message: message)
        logger.senna.log(level: .info, message: message)
        logger.senna.log(level: .notice, message: message)
        logger.senna.log(level: .warning, message: message)
        logger.senna.log(level: .error, message: message)
        logger.senna.log(level: .critical, message: message)
        XCTAssertEqual(message.description, """
        public message
        public sint +256)
        public sint +000256)
        public uint 256)
        public uint +000256)
        public double 3.141593
        public double +3.141593
        public float 3.141593
        public float +3.141593
        public bool true
        public bool false
        public meta Logger
        """)
    }

    #if canImport(CoreGraphics)
    func testCGFloat() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let message: Message = """
        public message
        public cgfloat \(CGFloat(Double.pi), format: .fixed(precision: 6, explicitPositiveSign: true), privacy: .public)
        """
        logger.senna.trace(message)
        logger.senna.debug(message)
        logger.senna.info(message)
        logger.senna.notice(message)
        logger.senna.warning(message)
        logger.senna.error(message)
        logger.senna.critical(message)
        XCTAssertEqual(message.description, """
        public message
        public cgfloat +3.141593
        """)
    }
    #endif

    #if canImport(ObjectiveC)
    func testNSObject() {
        let logger = Logger(label: "stdout") {
            Handler(name: $0, sink: StandardSink.out(), formation: Formation.standard, logLevel: .trace)
        }
        let message: Message = """
        public message
        public nsobject \(self, privacy: .public)
        """
        logger.senna.trace(message)
        logger.senna.debug(message)
        logger.senna.info(message)
        logger.senna.notice(message)
        logger.senna.warning(message)
        logger.senna.error(message)
        logger.senna.critical(message)
        XCTAssertEqual(message.description, """
        public message
        public nsobject \(String(describing: self))
        """)
    }
    #endif
}
