//
// Created by Mengyu Li on 2020/8/12.
//

import Foundation
import Logging

public protocol Printable {
    func emoji(for level: Logger.Level, component: Component) -> String?
    func textColor(for level: Logger.Level, component: Component) -> Color?
    func backgroundColor(for level: Logger.Level, component: Component) -> Color?
    func styles(for level: Logger.Level, component: Component) -> [Style]?
}

public extension Printable {
    func emoji(for level: Logger.Level, component: Component) -> String? { nil }

    func textColor(for level: Logger.Level, component: Component) -> Color? { nil }

    func backgroundColor(for level: Logger.Level, component: Component) -> Color? { nil }

    func styles(for level: Logger.Level, component: Component) -> [Style]? { nil }
}
