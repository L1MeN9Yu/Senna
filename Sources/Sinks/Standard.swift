//
// Created by Mengyu Li on 2020/8/11.
//

#if os(Linux)
import Glibc
#else
import Darwin
#endif
import Foundation
import struct Logging.Logger

public struct Standard {
    private let stream: FileDescriptorTextOutputStream
    private let flushMode: FlushMode

    private init(stream: FileDescriptorTextOutputStream, flushMode: FlushMode = .none) {
        self.stream = stream
        self.flushMode = flushMode
    }
}

extension Standard: Sink {
    public func process(_ formattedLog: String, _ level: Logger.Level) {
        var stream = self.stream
        let flush: Bool
        switch flushMode {
        case .none:
            flush = false
        case let .when(whenLevel):
            flush = level >= whenLevel ? true : false
        case .always:
            flush = true
        }
        stream.write("\(formattedLog)\n", flush: flush)
    }
}

public extension Standard {
    static let out = Standard(stream: StandardOutStream())
    static let error = Standard(stream: StandardErrorStream())
}

private struct StandardOutStream: FileDescriptorTextOutputStream {
    fileprivate init() {}

    fileprivate let file: UnsafeMutablePointer<FILE> = STDOUT

    func write(_ string: String) {
        flockfile(file)
        defer { funlockfile(file) }
        string.withCString { (ptr) -> Void in
            fputs(ptr, file)
        }
    }
}

private struct StandardErrorStream: FileDescriptorTextOutputStream {
    fileprivate init() {}

    fileprivate let file: UnsafeMutablePointer<FILE> = STDERR

    func write(_ string: String) {
        flockfile(file)
        defer { funlockfile(file) }
        string.withCString { (ptr) -> Void in
            fputs(ptr, file)
        }
    }
}

#if os(Linux)
private let STDOUT = Glibc.stdout!
private let STDERR = Glibc.stderr!
#else
private let STDOUT = Darwin.stdout
private let STDERR = Darwin.stderr
#endif
