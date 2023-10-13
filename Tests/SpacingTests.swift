//
// Created by mengyu.li on 2023/10/13.
//

@testable import Senna
import XCTest

final class SpacingTests: XCTestCase {
    func testSpacer() {
        let spacer = Spacer {
            switch $0 {
            case .level:
                return .center(truncate: Spacer.Truncate(max: 5, truncate: true))
            case .name:
                return .left(truncate: Spacer.Truncate(max: 3, truncate: false))
            case .line:
                return .right(truncate: Spacer.Truncate(max: 8, truncate: false))
            case .source:
                return .left(truncate: Spacer.Truncate(max: 16, truncate: false))
            case .timestamp:
                return .right(truncate: Spacer.Truncate(max: 4, truncate: true))
            default:
                return .raw
            }
        }
        let formation = Formation(components: [.name, .timestamp, .level, .source, .line, .message], spacer: spacer)
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
