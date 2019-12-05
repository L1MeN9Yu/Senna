//
//  Senna.swift
//  Senna
//
//  Created by Mengyu Li on 2019/8/22.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

import Foundation

public func register(loggers: [Logger]) {
    assert(!loggers.isEmpty)
    loggers.forEach { logger in
        register(logger: logger)
    }
}

public func drop(loggers: [Logger]) {
    assert(!loggers.isEmpty)
    loggers.forEach { logger in
        drop(logger: logger)
    }
}

public func register(logger: Logger) {
    if let loggerName = logger.name.cString(using: .utf8),
       let pattern = logger.pattern.cString(using: .utf8) {
        senna_add_logger(loggerName, logger.flag.unsignedIntValue, pattern)
    }
}

public func drop(logger: Logger) {
    if let loggerName = logger.name.cString(using: .utf8) {
        senna_drop_logger(loggerName)
    }
}

public typealias MessageConvert = (_ message: CustomStringConvertible?, _ filename: String, _ function: String, _ line: Int) -> String

public func register(messageConvert: @escaping MessageConvert) {
    __messageConvert = messageConvert
}

var __messageConvert: MessageConvert = { message, filename, function, line in
    let allMessage = "[\(URL(fileURLWithPath: filename).lastPathComponent):\(line)] \(function) - \(message?.description ?? "")"
    return allMessage
}

public let DefaultPattern = "[%D %T] [%=10n] %^[pid : %P] [tid : %t] [%8l] %v%$"

public func shutDown() {
    senna_shutdown()
}