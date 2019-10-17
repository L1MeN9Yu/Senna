//
// Created by Mengyu Li on 2019/9/30.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation
import Senna

class DemoLogger: Logger {
    let name: String = "SennaDemo"

    init() { self.register().enableSysLog().enableOSLog(subSystem: "sub system", category: "category",format: false) }

    deinit { self.drop() }
}
