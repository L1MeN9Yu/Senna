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
        senna_logger_flush(name)
    }

    @discardableResult
    public func setFlush(on flag: LogFlag) -> Self {
        senna_logger_set_flush_on(name, flag.unsignedIntValue)
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
        senna_logger_enable_file(name, flag.unsignedIntValue, pattern, filePath)
        return self
    }

    @discardableResult
    public func enableSysLog(flag: LogFlag = .trace, pattern: String = DefaultPattern, ident: String? = nil, option: Int32 = 0, facility: Int32 = LOG_USER, format: Bool = true) -> Self {
        let ident = ident ?? self.name
        senna_logger_enable_syslog(name, flag.unsignedIntValue, pattern, ident, option, facility, format)
        return self
    }

    @discardableResult
    public func enableOSLog(flag: LogFlag = .trace, pattern: String = DefaultOSLogPattern, subSystem: String = "Senna", category: String = "Logger", format: Bool = true) -> Self {
        senna_logger_enable_oslog(name, flag.unsignedIntValue, pattern, subSystem.cString(using: .utf8), category.cString(using: .utf8), format)
        return self
    }

    @discardableResult
    public func enableRotatingFileLog(flag: LogFlag = .trace, pattern: String = DefaultPattern, filePath: String, maxSize: Int = 1024 * 1024, maxFiles: Int = 1000) -> Self {
        senna_logger_enable_rotating_file(name, flag.unsignedIntValue, pattern, filePath, maxSize, maxFiles)
        return self
    }

    @discardableResult
    public func enableDailyFileLog(flag: LogFlag = .trace, pattern: String = DefaultPattern, filePath: String, hour: Int = 00, minute: Int = 00) -> Self {
        senna_logger_enable_daily_file(name, flag.unsignedIntValue, pattern, filePath, CInt(hour), CInt(minute))
        return self
    }
}

// MARK: - Log
extension Logger {
    public func log(flag: LogFlag, _ message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        senna_log_action(self.name, flag.unsignedIntValue, __messageConvert(message, filename, function, line))
    }

    public func trace(_ message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .trace, message, filename: filename, function: function, line: line)
    }

    public func debug(_ message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .debug, message, filename: filename, function: function, line: line)
    }

    public func info(_ message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .info, message, filename: filename, function: function, line: line)
    }

    public func warn(_ message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .warn, message, filename: filename, function: function, line: line)
    }

    public func error(_ message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .error, message, filename: filename, function: function, line: line)
    }

    public func crit(_ message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
        self.log(flag: .crit, message, filename: filename, function: function, line: line)
    }
}
