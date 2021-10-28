//
// Created by Mengyu Li on 2021/10/28.
//

@testable import Senna
import XCTest

final class OSTests: XCTestCase {
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    @available(OSX 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
    func testOS() {
        let logger = Logger(label: "OSLog") {
            Handler(name: $0, sink: OS(subsystem: "subsystem", category: "category"), formatter: Formatter.os, logLevel: .trace)
        }
        logger.trace("\(UInt8.max)")
        logger.debug("\(UInt8.max)")
        logger.info("\(UInt8.max)")
        logger.notice("\(UInt8.max)")
        logger.warning("\(UInt8.max)")
        logger.error("\(UInt8.max)")
        logger.critical("\(UInt8.max)")
    }
    #else
    #endif
}
