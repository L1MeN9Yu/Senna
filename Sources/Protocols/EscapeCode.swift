//
// Created by Mengyu Li on 2020/8/12.
//

public protocol EscapeCode: SennaEscapeCode {
    var value: [UInt8] { get }
}

#if compiler(>=5.6)
@preconcurrency public protocol SennaEscapeCode: Sendable {}
#else
public protocol SennaEscapeCode {}
#endif
