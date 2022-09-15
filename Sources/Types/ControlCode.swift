//
// Created by Mengyu Li on 2020/8/12.
//

enum ControlCode {
    static let ESC = "\u{001B}"
    static let CSI = "\(ESC)["
}

#if compiler(>=5.6)
extension ControlCode: Sendable {}
#endif
