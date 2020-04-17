//
//  ViewController.swift
//  Senna.Demo.iOS
//
//  Created by Mengyu Li on 2019/12/13.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

import UIKit
import Senna

class ViewController: UIViewController {

    let logger = Logger()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        logger.trace("trace")
        logger.debug("debug")
        logger.info("info")
        logger.warn("warn")
        logger.error("error")
        logger.crit("crit")
    }
}

class Logger: Senna.Logger {
    let name: String = "Demo"

    init() {
        register().enableOSLog(subSystem: "", category: "")
    }

    deinit {
        drop()
    }
}

