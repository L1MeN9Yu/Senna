//
// Created by Mengyu Li on 2022/3/1.
//

import Logging

extension Logger: Compatible {}

public extension Box where T == Logger {
    @inlinable
    func log(level: Logger.Level, message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.log(level: level, "\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }

    @inlinable
    func trace(_ message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.trace("\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }

    @inlinable
    func debug(_ message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.debug("\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }

    @inlinable
    func info(_ message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.info("\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }

    @inlinable
    func notice(_ message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.notice("\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }

    @inlinable
    func warning(_ message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.warning("\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }

    @inlinable
    func error(_ message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.error("\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }

    @inlinable
    func critical(_ message: @autoclosure () -> Message, metadata: @autoclosure () -> Logger.Metadata? = nil, source: @autoclosure () -> String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        value.critical("\(message().description)", metadata: metadata(), source: source(), file: file, function: function, line: line)
    }
}
