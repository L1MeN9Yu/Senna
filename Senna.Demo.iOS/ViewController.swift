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
        
        logger.trace(message: "trace")
        logger.debug(message: "trace")
        logger.info(message: "trace")
        logger.warning(message: "trace")
        logger.error(message: "trace")
        logger.critical(message: "trace")
    }
}

class Logger: Senna.Logger {
    let name: String = "Demo"
        
    init() {
        register()
    }
    
    deinit {
        drop()
    }
}

