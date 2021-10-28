//
// Created by Mengyu Li on 2020/8/19.
//

#if os(iOS) || os(OSX) || os(tvOS) || os(watchOS)
import Logging
import os.log

@available(OSX 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
public struct OSLogSink: SinkCapable {
    private let osLog: OSLog

    public init(subsystem: String, category: String) {
        osLog = OSLog(subsystem: subsystem, category: category)
    }

    public func process(_ formattedLog: String, _ level: Logging.Logger.Level) {
        os_log("%{public}@", log: osLog, type: OSLogType.from(loggerLevel: level), formattedLog)
    }
}

@available(OSX 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension OSLogType {
    static func from(loggerLevel: Logging.Logger.Level) -> Self {
        switch loggerLevel {
        case .trace, .debug:
            return .debug
        case .info, .notice, .warning:
            return .info
        case .error:
            return .error
        case .critical:
            return .fault
        }
    }
}
#endif
