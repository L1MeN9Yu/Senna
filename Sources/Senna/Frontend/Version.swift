//
// Created by Mengyu Li on 2020/7/7.
//

import Foundation

private let _major = 1
private let _minor = 2
private let _patch = 29

public struct Version {
	let major: Int
	let minor: Int
	let patch: Int

	public init(major: Int, minor: Int, patch: Int) {
		self.major = major
		self.minor = minor
		self.patch = patch
	}
}

extension Version: CustomStringConvertible {
	public var description: String { "\(major).\(minor).\(patch)" }
}

public extension Version {
	static let current = Version(major: _major, minor: _minor, patch: _patch)
	static let spdlog = { () -> Version in
		let majorPointer = UnsafeMutablePointer<Int32>.allocate(capacity: MemoryLayout<Int32>.size)
		defer { majorPointer.deallocate() }
		let minorPointer = UnsafeMutablePointer<Int32>.allocate(capacity: MemoryLayout<Int32>.size)
		defer { minorPointer.deallocate() }
		let patchPointer = UnsafeMutablePointer<Int32>.allocate(capacity: MemoryLayout<Int32>.size)
		defer { patchPointer.deallocate() }
		senna_spdlog_version(majorPointer, minorPointer, patchPointer)
		return Version(major: Int(majorPointer.pointee), minor: Int(minorPointer.pointee), patch: Int(patchPointer.pointee))
	}()

	static let fmt = { () -> Version in
		let versionPointer = UnsafeMutablePointer<Int32>.allocate(capacity: MemoryLayout<Int32>.size)
		defer { versionPointer.deallocate() }
		senna_fmt_version(versionPointer)
		let version = versionPointer.pointee
		let major = version / 10000
		let minor = (version - major * 10000) / 100
		let patch = version - major * 10000 - minor * 100
		return Version(major: Int(major), minor: Int(minor), patch: Int(patch))
	}()
}
