//
// Created by Mengyu Li on 2019/8/23.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation

public func log(flag: LogFlag, message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    if let allMessage = __messageConvert(message, filename, function, line).cString(using: .utf8) {
        senna_default_logger_log(flag.rawValue, allMessage)
    }
}

public func logTrace(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    log(flag: .trace, message: message, filename: filename, function: function, line: line)
}

public func logDebug(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    log(flag: .debug, message: message, filename: filename, function: function, line: line)
}

public func logInfo(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    log(flag: .info, message: message, filename: filename, function: function, line: line)
}

public func logWarning(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    log(flag: .warning, message: message, filename: filename, function: function, line: line)
}

public func logError(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    log(flag: .error, message: message, filename: filename, function: function, line: line)
}

public func logCritical(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    log(flag: .critical, message: message, filename: filename, function: function, line: line)
}
