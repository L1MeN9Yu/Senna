//
// Created by Mengyu Li on 2022/3/2.
//

@testable import Senna
import XCTest

final class ReadmeTests: XCTestCase {
    func testSimpleOut() {
        // create sink
        let sink = StandardSink.out()
        // create formation
        let formation = Formation.standard
        // create log
        let logger = Logger(label: "LogName") {
            Handler(name: $0, sink: sink, formation: formation, logLevel: .trace)
        }
        // do some logs
        logger.trace("This is a trace message")
        logger.debug("This is a debug message")
        logger.info("This is a info message")
        logger.notice("This is a notice message")
        logger.warning("This is a warning message")
        logger.error("This is a error message")
        logger.critical("This is a critical message")
    }

    func testMetaData() {
        // create sink
        let sink = StandardSink.out()
        // create formation
        let formation = Formation.standard
        // create log
        var logger = Logger(label: "LogName") {
            Handler(name: $0, sink: sink, formation: formation, logLevel: .trace)
        }
        logger[metadataKey: "UserID"] = .stringConvertible(9527)
        logger.info("message with logger meta data")
        logger.info("message with both logger and message meta data", metadata: ["UserName": .string("L1MeN9Yu")])
    }

    func testStandardXcode() {
        // create sink
        let sink = StandardSink.out()
        // create formation
        let formation = Formation.standardXcode
        // create log
        var logger = Logger(label: "LogName") {
            Handler(name: $0, sink: sink, formation: formation, logLevel: .trace)
        }

        logger.trace("This is a trace message")
        logger.debug("This is a debug message")
        logger.info("This is a info message")
        logger.notice("This is a notice message")
        logger.warning("This is a warning message")
        logger.error("This is a error message")
        logger.critical("This is a critical message")

        logger[metadataKey: "UserID"] = .stringConvertible(9527)
        logger.info("message with logger meta data")
        logger.info("message with both logger and message meta data", metadata: ["UserName": .string("L1MeN9Yu")])
    }

    func testStringInterpolation() {
        let sink = StandardSink.out()
        let formation = Formation.standard
        var logger = Logger(label: "LogName") {
            Handler(name: $0, sink: sink, formation: formation, logLevel: .trace)
        }
        logger[metadataKey: "UserID"] = .stringConvertible(9527)
        #if DEBUG
        let privacy = Privacy.public
        #else
        let privacy = Privacy.private
        #endif
        // default is private
        logger.senna.notice("the user name is \("L1MeN9Yu")")
        logger.senna.notice("the user name is \("L1MeN9Yu", privacy: privacy)")
    }
}
