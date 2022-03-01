//
// Created by Mengyu Li on 2021/10/28.
//

@testable import Senna
import XCTest

final class FileSinkTests: XCTestCase {
    func testFile() throws {
        let fileURL = URL(fileURLWithPath: "file.log")
        try Data().write(to: fileURL, options: .atomic)
        let fileSink = FileSink(fileURL.path)
        let logger = Logger(label: "File") {
            Handler(name: $0, sink: fileSink, formation: Formation.file, logLevel: .trace)
        }
        var count = 10
        while count > 0 {
            logger.trace("\(UInt8.random(in: .min ..< .max))")
            logger.debug("\(UInt8.random(in: .min ..< .max))")
            logger.info("\(UInt8.random(in: .min ..< .max))")
            logger.notice("\(UInt8.random(in: .min ..< .max))")
            logger.warning("\(UInt8.random(in: .min ..< .max))")
            logger.error("\(UInt8.random(in: .min ..< .max))")
            logger.critical("\(UInt8.random(in: .min ..< .max))")
            count -= 1
        }

        fileSink.flush().close()

        guard let fileContents = try String(data: Data(contentsOf: fileURL), encoding: .utf8) else {
            return XCTFail("logging to file failed")
        }

        XCTAssertEqual(fileContents.split(separator: "\n").count, 70)
    }

    func testFileFlushAlways() throws {
        let fileURL = URL(fileURLWithPath: "file.log")
        try Data().write(to: fileURL, options: .atomic)
        let fileSink = FileSink(fileURL.path, flushMode: .always)
        let logger = Logger(label: "File") {
            Handler(name: $0, sink: fileSink, formation: Formation.file, logLevel: .trace)
        }
        var count = 10
        while count > 0 {
            logger.trace("\(UInt8.random(in: .min ..< .max))")
            logger.debug("\(UInt8.random(in: .min ..< .max))")
            logger.info("\(UInt8.random(in: .min ..< .max))")
            logger.notice("\(UInt8.random(in: .min ..< .max))")
            logger.warning("\(UInt8.random(in: .min ..< .max))")
            logger.error("\(UInt8.random(in: .min ..< .max))")
            logger.critical("\(UInt8.random(in: .min ..< .max))")
            count -= 1
        }

        fileSink.close()

        guard let fileContents = try String(data: Data(contentsOf: fileURL), encoding: .utf8) else {
            return XCTFail("logging to file failed")
        }

        XCTAssertEqual(fileContents.split(separator: "\n").count, 70)
    }

    func testFileFlushWhen() throws {
        let fileURL = URL(fileURLWithPath: "file.log")
        try Data().write(to: fileURL, options: .atomic)
        let fileSink = FileSink(fileURL.path, flushMode: .when(.warning))
        let logger = Logger(label: "File") {
            Handler(name: $0, sink: fileSink, formation: Formation.file, logLevel: .trace)
        }
        var count = 10
        while count > 0 {
            logger.trace("\(UInt8.random(in: .min ..< .max))")
            logger.debug("\(UInt8.random(in: .min ..< .max))")
            logger.info("\(UInt8.random(in: .min ..< .max))")
            logger.notice("\(UInt8.random(in: .min ..< .max))")
            logger.warning("\(UInt8.random(in: .min ..< .max))")
            logger.error("\(UInt8.random(in: .min ..< .max))")
            logger.critical("\(UInt8.random(in: .min ..< .max))")
            count -= 1
        }

        fileSink.close()

        guard let fileContents = try String(data: Data(contentsOf: fileURL), encoding: .utf8) else {
            return XCTFail("logging to file failed")
        }

        XCTAssertEqual(fileContents.split(separator: "\n").count, 70)
    }
}
