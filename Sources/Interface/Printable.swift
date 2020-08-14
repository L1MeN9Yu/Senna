//
// Created by Mengyu Li on 2020/8/12.
//

import Foundation
import Logging

public protocol Printable {
	func textColor(for level: Logger.Level, component: Component) -> Color?
	func backgroundColor(for level: Logger.Level, component: Component) -> Color?
	func styles(for level: Logger.Level, component: Component) -> [Style]?
}

extension Printable {
	public func textColor(for level: Logger.Level, component: Component) -> Color? { nil }

	public func backgroundColor(for level: Logger.Level, component: Component) -> Color? { nil }

	public func styles(for level: Logger.Level, component: Component) -> [Style]? { nil }
}
