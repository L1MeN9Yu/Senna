//
// Created by Mengyu Li on 2020/8/14.
//

import Darwin
import Foundation
import struct Logging.Logger

public struct File {
    public let fileURL: URL
    private let fileStream: FileStream

    public init(_ url: URL) {
        fileURL = url
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
        fileStream.write("\(formattedLog)\n")
    }
}

private struct FileStream: TextOutputStream {
    private let file: UnsafeMutablePointer<FILE>

    fileprivate init(_ file: UnsafeMutablePointer<FILE>) {
        self.file = file
    }

    public func write(_ string: String) {
        flockfile(file)
        defer { funlockfile(file) }
        string.withCString { (ptr) -> Void in
            fputs(ptr, file)
        }
        fflush(file)
    }
}
