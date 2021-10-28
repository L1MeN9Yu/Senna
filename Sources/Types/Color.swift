//
// Created by Mengyu Li on 2020/8/12.
//

public struct Color {
    let red: UInt8
    let green: UInt8
    let blue: UInt8
}

extension Color: EscapeCode {
    public var value: [UInt8] {
        [red, green, blue]
    }
}
