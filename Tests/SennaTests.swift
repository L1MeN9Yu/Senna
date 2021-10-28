#if os(Linux)
import Glibc
#else
import Darwin
#endif
import Foundation
import Logging
@testable import Senna
import XCTest

final class SennaTests: XCTestCase {
    func testStandardOut() {
        var logger = Logger(label: "Standard") {
            Handler(name: $0, sink: Standard.out, formatter: Formatter.standard, logLevel: .trace)
        }
        logger.trace("\(UInt8.max)")
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)")
        logger.logLevel = .error
        logger.info("Test info message")
    }

    func testFile() {
        let fileURL = URL(fileURLWithPath: "file")
        var logger = Logger(label: "Standard") {
            Handler(name: $0, sink: File(fileURL.path), formatter: Formatter.file, logLevel: .trace)
        }
        var count = 500
        while count >= 0 {
            logger.trace("\(UInt8.max)")
            logger.debug("\(UInt8.max)")
            logger.info("\(UInt8.max)")
            logger.notice("\(UInt8.max)")
            logger.warning("\(UInt8.max)")
            logger.error("\(UInt8.max)")
            logger.critical("\(UInt8.max)")
            count -= 1
            Thread.sleep(forTimeInterval: 0.1)
        }

        logger.logLevel = .error
        logger.info("Test info message")
    }

    #if os(Linux)
    #else
    @available(OSX 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
    func testOS() {
        var logger = Logger(label: "Standard") {
            Handler(name: $0, sink: OS(subsystem: "subsystem", category: "category"), formatter: Formatter.os, logLevel: .trace)
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
    #endif

    func testMultiHandler() throws {
        let fileURL = URL(fileURLWithPath: ProcessInfo.processInfo.globallyUniqueString)
        print("url = \(fileURL)")
        var logger = Logger(label: "Multi") {
            MultiplexLogHandler([
                Handler(name: $0, sink: Standard.out, formatter: Formatter.standard, logLevel: .trace),
                Handler(name: $0, sink: File(fileURL.path), formatter: Formatter.file, logLevel: .trace),
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
