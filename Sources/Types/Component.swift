//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation

public enum Component {
    /// The name
    case name

    /// Timestamp of log
    case timestamp

    /// Log level
    case level
    /// The actual message
    case message
    /// Log metadata
    case metadata
    /// The log's messages originates to
    case source
    /// The log's originating file
    case file
    /// The log's originating function
    case function
    /// The log's originating line number
    case line

    /// Literal text
    case text(String)
    /// A group of `Components`, not using the specified `separator`
    case group([Component])
}
