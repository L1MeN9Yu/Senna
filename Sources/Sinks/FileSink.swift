//
// Created by Mengyu Li on 2020/8/14.
//

#if os(Linux)
import Glibc
#else
import Darwin
#endif
import Logging

public struct FileSink {
    public let path: String
    private let fileStream: FileStream
    private let flushMode: FlushMode

    public init(_ path: String, flushMode: FlushMode = .none) {
        self.path = path
        self.flushMode = flushMode
        let file = path.withCString { (filename: UnsafePointer<Int8>) -> UnsafeMutablePointer<FILE> in
            "a".withCString { (mode: UnsafePointer<Int8>) -> UnsafeMutablePointer<FILE> in
                fopen(filename, mode)
            }
        }
        fileStream = FileStream(file)
    }
}

public extension FileSink {
    @discardableResult
    func flush() -> Self {
        fflush(fileStream.file)
        return self
    }

    @discardableResult
    func close() -> Self {
        fclose(fileStream.file)
        return self
    }
}

extension FileSink: SinkCapable {
    public func process(_ formattedLog: String, _ level: Logger.Level) {
        let flush: Bool
        switch flushMode {
        case .none:
            flush = false
        case let .when(whenLevel):
            flush = level >= whenLevel
        case .always:
            flush = true
        }
        var fileStream = fileStream
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
        fputs(string, file)
    }
}
