//
// Created by Mengyu Li on 2020/8/11.
//

import Darwin
import Foundation

public struct Standard {
	private let stream: TextOutputStream

	private init(stream: TextOutputStream) { self.stream = stream }
}

extension Standard: Sink {
	public func process(_ formattedLog: String) {
		var stream = self.stream
		stream.write("\(formattedLog)\n")
	}
}

public extension Standard {
	static let out = Standard(stream: StandardOutStream())
	static let error = Standard(stream: StandardErrorStream())
}

private struct StandardOutStream: TextOutputStream {
	fileprivate init() {}

	private let file: UnsafeMutablePointer<FILE> = Darwin.stdout

	func write(_ string: String) {
		flockfile(file)
		defer { funlockfile(file) }
		string.withCString { (ptr) -> Void in
			fputs(ptr, file)
		}
	}
}

private struct StandardErrorStream: TextOutputStream {
	fileprivate init() {}

	private let file: UnsafeMutablePointer<FILE> = Darwin.stderr

	func write(_ string: String) {
		flockfile(file)
		defer { funlockfile(file) }
		string.withCString { (ptr) -> Void in
			fputs(ptr, file)
		}
	}
}
