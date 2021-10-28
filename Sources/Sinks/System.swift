//
// Created by Mengyu Li on 2021/10/28.
//

#if os(iOS) || os(OSX) || os(tvOS) || os(watchOS)
import Darwin.POSIX.syslog
#elseif os(Linux)
import Glibc
#else
#error("not support yet")
#endif

struct System: Sink {
    func process(_ formattedLog: String, _ level: Logger.Level) {
        withVaList([]) { args in
            formattedLog.withCString {
                vsyslog(priority(level), $0, args)
            }
        }
    }
}

private extension System {
    func priority(_ level: Logger.Level) -> Int32 {
        switch level {
        case .trace:
            // `syslog` doesn't have `trace`, so use `LOG_DEBUG` instead.
            return LOG_DEBUG
        case .debug:
            return LOG_DEBUG
        case .info:
            return LOG_INFO
        case .notice:
            return LOG_NOTICE
        case .warning:
            return LOG_WARNING
        case .error:
            return LOG_ERR
        case .critical:
            return LOG_CRIT
        }
    }
}