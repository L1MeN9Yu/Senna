//
// Created by Mengyu Li on 2020/9/29.
//

import Foundation
import Logging

public enum FlushMode {
    case none
    case when(Logger.Level)
    case always
}
