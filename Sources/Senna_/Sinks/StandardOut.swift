//
// Created by Mengyu Li on 2020/8/11.
//

import Darwin
import Foundation

public struct StandardOut: Sink {
	private let stream: TextOutputStream

	public func process(_ formattedLog: String) {
		var stream = self.stream
		stream.write(formattedLog)
	}
}
