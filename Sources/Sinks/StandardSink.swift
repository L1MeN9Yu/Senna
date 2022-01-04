//
// Created by Mengyu Li on 2020/8/11.
//

#if os(Linux)
import Glibc
#else
import Darwin
#endif
import struct Logging.Logger

public struct StandardSink {
    private let stream: FileDescriptorTextOutputStream
    private let flushMode: FlushMode

    private init(stream: FileDescriptorTextOutputStream, flushMode: FlushMode = .none) {
        self.stream = stream
        self.flushMode = flushMode
    }
}

extension StandardSink: SinkCapable {
    public func process(_ formattedLog: String, _ level: Logger.Level) {
        var stream = stream
        let flush: Bool
        switch flushMode {
        case .none:
            flush = false
        case let .when(whenLevel):
            flush = level >= whenLevel
        case .always:
            flush = true
        }
        stream.write("\(formattedLog)\n", flush: flush)
    }
}

public extension StandardSink {
    static func out(flushMode: FlushMode = .none) -> Self {
        StandardSink(stream: StandardOutStream(), flushMode: flushMode)
    }

    static func error(flushMode: FlushMode = .none) -> Self {
        StandardSink(stream: StandardErrorStream(), flushMode: flushMode)
    }
}

private struct StandardOutStream: FileDescriptorTextOutputStream {
    fileprivate init() {}

    fileprivate let file: UnsafeMutablePointer<FILE> = STDOUT

    func write(_ string: String) {
        flockfile(file)
        defer { funlockfile(file) }
        fputs(string, file)
    }
}

private struct StandardErrorStream: FileDescriptorTextOutputStream {
    fileprivate init() {}

    fileprivate let file: UnsafeMutablePointer<FILE> = STDERR

    func write(_ string: String) {
        flockfile(file)
        defer { funlockfile(file) }
        fputs(string, file)
    }
}

#if os(Linux)
private let STDOUT = Glibc.stdout.unsafelyUnwrapped
private let STDERR = Glibc.stderr.unsafelyUnwrapped
#else
private let STDOUT = Darwin.stdout
private let STDERR = Darwin.stderr
#endif
