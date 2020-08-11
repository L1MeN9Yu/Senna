//
// Created by Mengyu Li on 2020/8/11.
//

import Foundation

public protocol Sink {
	func process(_ formattedLog: String)
}
