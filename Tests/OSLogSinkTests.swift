//
// Created by Mengyu Li on 2021/10/28.
//

@testable import Senna
import XCTest

final class OSLogSinkTests: XCTestCase {
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    @available(OSX 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
    func testOS() {
        let logger = Logger(label: "OSLog") {
            Handler(name: $0, sink: OSLogSink(subsystem: "subsystem", category: "category"), formation: Formation.os, logLevel: .trace)
        }
        logger.trace("\(UInt8.random(in: .min ..< .max))")
        logger.debug("\(UInt8.random(in: .min ..< .max))")
        logger.info("\(UInt8.random(in: .min ..< .max))")
        logger.notice("\(UInt8.random(in: .min ..< .max))")
        logger.warning("\(UInt8.random(in: .min ..< .max))")
        logger.error("\(UInt8.random(in: .min ..< .max))")
        logger.critical("\(UInt8.random(in: .min ..< .max))")
    }
    #else
    #endif
}
