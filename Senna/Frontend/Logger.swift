//
// Created by Mengyu Li on 2019/8/23.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation
import Darwin.POSIX.syslog

public protocol Logger {
    var name: String { get }
    var pattern: String { get }
}

// MARK: - Life Cycle
extension Logger {
    @discardableResult
    public func register() -> Self {
        Senna.register(logger: self)
        return self
    }

    public func drop() { Senna.drop(logger: self) }
}

// MARK: - Default Values
extension Logger {
    public var pattern: String {
        DefaultPattern
    }
}

// MARK: - Features
extension Logger {

    @discardableResult
    public func enableSysLog(pattern: String = DefaultPattern, ident: String? = nil, option: Int32 = 0, facility: Int32 = LOG_USER, format: Bool = false) -> Self {
        let ident = ident ?? self.name
        let loggerName = self.name.cString(using: .utf8)
        let pattern = pattern.cString(using: .utf8)

        senna_logger_enable_syslog(loggerName, pattern, ident, option, facility, format)

        return self
    }

    @discardableResult
    public func enableRotatingFileLog(pattern: String = DefaultPattern, filePath: String, maxSize: Int = 1024 * 1024, maxFiles: Int = 1000) -> Self {
        let loggerName = self.name.cString(using: .utf8)
        let filePath = filePath.cString(using: .utf8)
        let pattern = pattern.cString(using: .utf8)

        senna_logger_enable_rotating_file(loggerName, pattern, filePath, maxSize, maxFiles)
        return self
    }

    @discardableResult
    public func enableDailyFileLog(pattern: String = DefaultPattern, filePath: String, hour: Int = 00, minute: Int = 00) -> Self {
        let loggerName = self.name.cString(using: .utf8)
        let filePath = filePath.cString(using: .utf8)
        let pattern = pattern.cString(using: .utf8)

        senna_logger_enable_daily_file(loggerName, pattern, filePath, CInt(hour), CInt(minute))
        return self
    }
}

// MARK: - Log
extension Logger {
    public func log(flag: LogFlag, message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        let allMessage = AllMessage(message, filename, function, line).cString(using: .utf8)
        let loggerName = self.name.cString(using: .utf8)
        let flag = UInt32(flag.rawValue)
        senna_log_action(loggerName, flag, allMessage)
    }

    public func trace(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .trace, message: message, filename: filename, function: function, line: line)
    }

    public func debug(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .debug, message: message, filename: filename, function: function, line: line)
    }

    public func info(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .info, message: message, filename: filename, function: function, line: line)
    }

    public func warning(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .warning, message: message, filename: filename, function: function, line: line)
    }

    public func error(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .error, message: message, filename: filename, function: function, line: line)
    }

    public func critical(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .critical, message: message, filename: filename, function: function, line: line)
    }
}