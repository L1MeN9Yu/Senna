//
// Created by Mengyu Li on 2020/8/11.
//

import Foundation
import Logging

struct StandardOutStream: TextOutputStream {
	let file: UnsafeMutablePointer<FILE> = Darwin.stdout

	func write(_ string: String) {
		string.withCString { ptr in
			flockfile(file)
			defer { funlockfile(file) }
			_ = fputs(ptr, file)
		}
	}
}
