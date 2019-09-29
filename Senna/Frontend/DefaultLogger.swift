//
// Created by Mengyu Li on 2019/8/23.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation

public func log(flag: LogFlag, message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    switch flag {
    case .trace:
        logTrace(message: message, filename: filename, function: function, line: line)
    case .debug:
        logDebug(message: message, filename: filename, function: function, line: line)
    case .info:
        logInfo(message: message, filename: filename, function: function, line: line)
    case .warning:
        logWarning(message: message, filename: filename, function: function, line: line)
    case .error:
        logError(message: message, filename: filename, function: function, line: line)
    case .critical:
        logCritical(message: message, filename: filename, function: function, line: line)
    }
}

public func logTrace(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    let allMessage = AllMessage(message, filename, function, line).cString(using: .utf8)
    c_senna_log_trace(message: allMessage)
}

public func logDebug(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    let allMessage = AllMessage(message, filename, function, line).cString(using: .utf8)
    c_senna_log_debug(message: allMessage)
}

public func logInfo(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    let allMessage = AllMessage(message, filename, function, line).cString(using: .utf8)
    c_senna_log_info(message: allMessage)
}

public func logWarning(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    let allMessage = AllMessage(message, filename, function, line).cString(using: .utf8)
    c_senna_log_warning(message: allMessage)
}

public func logError(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    let allMessage = AllMessage(message, filename, function, line).cString(using: .utf8)
    c_senna_log_error(message: allMessage)
}

public func logCritical(message: CustomStringConvertible?, filename: String = #file, function: String = #function, line: Int = #line) {
    let allMessage = AllMessage(message, filename, function, line).cString(using: .utf8)
    c_senna_log_critical(message: allMessage)
}
