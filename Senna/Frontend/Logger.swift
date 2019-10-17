//
// Created by Mengyu Li on 2019/8/23.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation
import Darwin.POSIX.syslog

public protocol Logger {
    var name: String { get }
    var pattern: String { get }
    var flag: LogFlag { get }
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

// MARK: - Flush
extension Logger {
    public func flush() {
        if let name = self.name.cString(using: .utf8) {
            senna_logger_flush(name)
        }
    }

    @discardableResult
    public func setFlush(on flag: LogFlag) -> Self {
        if let name = self.name.cString(using: .utf8) {
            senna_logger_set_flush_on(name, flag.rawValue)
        }
        return self
    }
}

// MARK: - Default Values
extension Logger {
    public var pattern: String { DefaultPattern }

    public var flag: LogFlag { .trace }
}

// MARK: - Features
extension Logger {

    @discardableResult
    public func enableFileLog(flag: LogFlag = .trace, pattern: String = DefaultPattern, filePath: String) -> Self {
        if let loggerName = self.name.cString(using: .utf8),
           let filePath = filePath.cString(using: .utf8),
           let pattern = pattern.cString(using: .utf8) {
            senna_logger_enable_file(loggerName, flag.rawValue, pattern, filePath)
        }
        return self
    }

    @discardableResult
    public func enableSysLog(flag: LogFlag = .trace, pattern: String = DefaultPattern, ident: String? = nil, option: Int32 = 0, facility: Int32 = LOG_USER, format: Bool = false) -> Self {
        let ident = ident ?? self.name
        if let loggerName = self.name.cString(using: .utf8),
           let pattern = pattern.cString(using: .utf8) {
            senna_logger_enable_syslog(loggerName, flag.rawValue, pattern, ident, option, facility, format)
        }

        return self
    }

    @discardableResult
    public func enableRotatingFileLog(flag: LogFlag = .trace, pattern: String = DefaultPattern, filePath: String, maxSize: Int = 1024 * 1024, maxFiles: Int = 1000) -> Self {
        if let loggerName = self.name.cString(using: .utf8),
           let filePath = filePath.cString(using: .utf8),
           let pattern = pattern.cString(using: .utf8) {
            senna_logger_enable_rotating_file(loggerName, flag.rawValue, pattern, filePath, maxSize, maxFiles)
        }

        return self
    }

    @discardableResult
    public func enableDailyFileLog(flag: LogFlag = .trace, pattern: String = DefaultPattern, filePath: String, hour: Int = 00, minute: Int = 00) -> Self {
        if let loggerName = self.name.cString(using: .utf8),
           let filePath = filePath.cString(using: .utf8),
           let pattern = pattern.cString(using: .utf8) {
            senna_logger_enable_daily_file(loggerName, flag.rawValue, pattern, filePath, CInt(hour), CInt(minute))
        }

        return self
    }
}

// MARK: - Log
extension Logger {
    public func log(flag: LogFlag, message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        if let allMessage = __messageConvert(message, filename, function, line).cString(using: .utf8),
           let loggerName = self.name.cString(using: .utf8) {
            let flag = UInt32(flag.rawValue)
            senna_log_action(loggerName, flag, allMessage)
        }
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