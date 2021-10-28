//
// Created by Mengyu Li on 2020/9/29.
//

#if os(Linux)
import Glibc
#else
import Darwin
#endif

protocol FileDescriptorTextOutputStream: TextOutputStream {
    var file: UnsafeMutablePointer<FILE> { get }
}

extension FileDescriptorTextOutputStream {
    mutating func write(_ string: String, flush: Bool) {
        write(string)
        if flush { fflush(file) }
    }
}
