//
// Created by Mengyu Li on 2020/8/10.
//

import Logging

public protocol Formable: SennaFormable {
    var components: [Component] { get }
    func format(name: String, level: Logger.Level, message: Logger.Message, prettyMetadata: String?, source: String, file: String, function: String, line: UInt) -> String
}

#if compiler(>=5.6)
@preconcurrency public protocol SennaFormable: Sendable {}
#else
public protocol SennaFormable {}
#endif
