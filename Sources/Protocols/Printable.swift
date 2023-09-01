//
// Created by Mengyu Li on 2020/8/12.
//

import Logging

public protocol Printable {
    func textColor(for level: Logger.Level, component: Component) -> EscapeCode?
    func backgroundColor(for level: Logger.Level, component: Component) -> EscapeCode?
    func styles(for level: Logger.Level, component: Component) -> [Style]?
}

public extension Printable {
    func textColor(for level: Logger.Level, component: Component) -> EscapeCode? { nil }

    func backgroundColor(for level: Logger.Level, component: Component) -> EscapeCode? { nil }

    func styles(for level: Logger.Level, component: Component) -> [Style]? { nil }
}
