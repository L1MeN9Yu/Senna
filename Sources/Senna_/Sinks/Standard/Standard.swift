//
// Created by Mengyu Li on 2020/8/11.
//

import Darwin
import Foundation

public struct Standard: Sink {
	private let stream: TextOutputStream

	public func process(_ formattedLog: String) {
		var stream = self.stream
		stream.write("\(formattedLog)\n")
	}

	private init(stream: TextOutputStream) { self.stream = stream }
}

public extension Standard {
	static let out = Standard(stream: StandardOutStream())
	static let error = Standard(stream: StandardErrorStream())
}

private struct StandardOutStream: TextOutputStream {
	let file: UnsafeMutablePointer<FILE> = Darwin.stdout

	func write(_ string: String) {
		flockfile(file)
		defer { funlockfile(file) }
		string.withCString { (ptr) -> () in
			fputs(ptr, file)
		}
	}
}

private struct StandardErrorStream: TextOutputStream {
	let file: UnsafeMutablePointer<FILE> = Darwin.stderr

	func write(_ string: String) {
		flockfile(file)
		defer { funlockfile(file) }
		string.withCString { (ptr) -> () in
			fputs(ptr, file)
		}
	}
}
