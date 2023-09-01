//
// Created by mengyu.li on 2023/9/1.
//

@testable import Senna
import XCTest

final class ColorTests: XCTestCase {
    func testLegacyTextColor() {
        XCTAssertEqual(LegacyTextColor.default.value[0], UInt8(39))
        let color8: [LegacyTextColor] = [
            LegacyTextColor.black,
            LegacyTextColor.red,
            LegacyTextColor.green,
            LegacyTextColor.yellow,
            LegacyTextColor.blue,
            LegacyTextColor.magenta,
            LegacyTextColor.cyan,
            LegacyTextColor.lightGray,
        ]
        XCTAssertEqual(color8[0].value[0], 30)
        XCTAssertEqual(color8[1].value[0], color8[0].value[0] + 1)
        XCTAssertEqual(color8[2].value[0], color8[0].value[0] + 2)
        XCTAssertEqual(color8[3].value[0], color8[0].value[0] + 3)
        XCTAssertEqual(color8[4].value[0], color8[0].value[0] + 4)
        XCTAssertEqual(color8[5].value[0], color8[0].value[0] + 5)
        XCTAssertEqual(color8[6].value[0], color8[0].value[0] + 6)
        XCTAssertEqual(color8[7].value[0], color8[0].value[0] + 7)

        let color16: [LegacyTextColor] = [
            LegacyTextColor.darkGray,
            LegacyTextColor.lightRed,
            LegacyTextColor.lightGreen,
            LegacyTextColor.lightYellow,
            LegacyTextColor.lightBlue,
            LegacyTextColor.lightMagenta,
            LegacyTextColor.lightCyan,
            LegacyTextColor.white,
        ]
        XCTAssertEqual(color16[0].value[0], 90)
        XCTAssertEqual(color16[1].value[0], color16[0].value[0] + 1)
        XCTAssertEqual(color16[2].value[0], color16[0].value[0] + 2)
        XCTAssertEqual(color16[3].value[0], color16[0].value[0] + 3)
        XCTAssertEqual(color16[4].value[0], color16[0].value[0] + 4)
        XCTAssertEqual(color16[5].value[0], color16[0].value[0] + 5)
        XCTAssertEqual(color16[6].value[0], color16[0].value[0] + 6)
        XCTAssertEqual(color16[7].value[0], color16[0].value[0] + 7)
    }

    func testLegacyBackgroundColor() {
        XCTAssertEqual(LegacyBackgroundColor.default.value[0], UInt8(49))
        let color8: [LegacyBackgroundColor] = [
            LegacyBackgroundColor.black,
            LegacyBackgroundColor.red,
            LegacyBackgroundColor.green,
            LegacyBackgroundColor.yellow,
            LegacyBackgroundColor.blue,
            LegacyBackgroundColor.magenta,
            LegacyBackgroundColor.cyan,
            LegacyBackgroundColor.lightGray,
        ]
        XCTAssertEqual(color8[0].value[0], 40)
        XCTAssertEqual(color8[1].value[0], color8[0].value[0] + 1)
        XCTAssertEqual(color8[2].value[0], color8[0].value[0] + 2)
        XCTAssertEqual(color8[3].value[0], color8[0].value[0] + 3)
        XCTAssertEqual(color8[4].value[0], color8[0].value[0] + 4)
        XCTAssertEqual(color8[5].value[0], color8[0].value[0] + 5)
        XCTAssertEqual(color8[6].value[0], color8[0].value[0] + 6)
        XCTAssertEqual(color8[7].value[0], color8[0].value[0] + 7)

        let color16: [LegacyBackgroundColor] = [
            LegacyBackgroundColor.darkGray,
            LegacyBackgroundColor.lightRed,
            LegacyBackgroundColor.lightGreen,
            LegacyBackgroundColor.lightYellow,
            LegacyBackgroundColor.lightBlue,
            LegacyBackgroundColor.lightMagenta,
            LegacyBackgroundColor.lightCyan,
            LegacyBackgroundColor.white,
        ]
        XCTAssertEqual(color16[0].value[0], 100)
        XCTAssertEqual(color16[1].value[0], color16[0].value[0] + 1)
        XCTAssertEqual(color16[2].value[0], color16[0].value[0] + 2)
        XCTAssertEqual(color16[3].value[0], color16[0].value[0] + 3)
        XCTAssertEqual(color16[4].value[0], color16[0].value[0] + 4)
        XCTAssertEqual(color16[5].value[0], color16[0].value[0] + 5)
        XCTAssertEqual(color16[6].value[0], color16[0].value[0] + 6)
        XCTAssertEqual(color16[7].value[0], color16[0].value[0] + 7)
    }
}
