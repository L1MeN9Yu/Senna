//
// Created by Mengyu Li on 2020/8/11.
//

import Logging

public protocol Sink {
    func process(_ formattedLog: String, _ level: Logger.Level)
}
