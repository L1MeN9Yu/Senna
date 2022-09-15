//
// Created by Mengyu Li on 2020/8/11.
//

import Logging

public protocol SinkCapable: SennaSinkCapable {
    func process(_ formattedLog: String, _ level: Logger.Level)
}

#if compiler(>=5.6)
@preconcurrency public protocol SennaSinkCapable: Sendable {}
#else
public protocol SennaSinkCapable {}
#endif
