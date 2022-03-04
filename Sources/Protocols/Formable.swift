//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation
import Logging

public protocol Formable {
    var components: [Component] { get }
    func format(name: String, level: Logger.Level, message: Logger.Message, prettyMetadata: String?, source: String, file: String, function: String, line: UInt) -> String
}
