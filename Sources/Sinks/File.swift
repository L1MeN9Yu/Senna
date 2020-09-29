//
// Created by Mengyu Li on 2020/8/14.
//

#if os(Linux)
import Glibc
#else
import Darwin
#endif
import Foundation
import struct Logging.Logger

public struct File {
    public let url: URL
    private let fileStream: FileStream
    private let flushMode: FlushMode

    public init(_ url: URL, flushMode: FlushMode = .none) {
        self.url = url
        self.flushMode = flushMode
        let file = url.path.withCString { (filename: UnsafePointer<Int8>) -> UnsafeMutablePointer<FILE> in
            "w".withCString { (mode: UnsafePointer<Int8>) -> UnsafeMutablePointer<FILE> in
                fopen(filename, mode)
            }
        }
        fileStream = FileStream(file)
    }
}

extension File: Sink {
    public func process(_ formattedLog: String, _ level: Logger.Level) {
        let flush: Bool
        switch flushMode {
        case .none:
            flush = false
        case let .when(whenLevel):
            flush = level >= whenLevel ? true : false
        case .always:
            flush = true
        }
        var fileStream = self.fileStream
        fileStream.write("\(formattedLog)\n", flush: flush)
    }
}

private struct FileStream: FileDescriptorTextOutputStream {
    fileprivate let file: UnsafeMutablePointer<FILE>

    fileprivate init(_ file: UnsafeMutablePointer<FILE>) {
        self.file = file
    }

    public func write(_ string: String) {
        flockfile(file)
        defer { funlockfile(file) }
        string.withCString { (ptr) -> Void in
            fputs(ptr, file)
        }
    }
}
