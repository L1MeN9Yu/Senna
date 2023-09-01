//
// Created by mengyu.li on 2023/9/1.
//

@testable import Senna
import XCTest

final class PrinterTests: XCTestCase {
    func testLegacy8Bit() {
        let formation = Formation(components: [.message], printer: Printer.legacy8bit)
        let logger = Logger(label: "LogName") {
            Handler(name: $0, sink: StandardSink.out(), formation: formation, logLevel: .trace)
        }

        logger.trace("This is a trace message")
        logger.debug("This is a debug message")
        logger.info("This is a info message")
        logger.notice("This is a notice message")
        logger.warning("This is a warning message")
        logger.error("This is a error message")
        logger.critical("This is a critical message")
    }

    func testLegacy16Bit() {
        let formation = Formation(components: [.message], printer: Printer.legacy16bit)
        let logger = Logger(label: "LogName") {
            Handler(name: $0, sink: StandardSink.out(), formation: formation, logLevel: .trace)
        }

        logger.trace("This is a trace message")
        logger.debug("This is a debug message")
        logger.info("This is a info message")
        logger.notice("This is a notice message")
        logger.warning("This is a warning message")
        logger.error("This is a error message")
        logger.critical("This is a critical message")
    }
}
