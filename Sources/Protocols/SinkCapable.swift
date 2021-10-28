//
// Created by Mengyu Li on 2020/8/11.
//

import Logging

public protocol SinkCapable {
    func process(_ formattedLog: String, _ level: Logger.Level)
}
