//
// Created by Mengyu Li on 2019/9/30.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation
import SwiftUI

class DemoListViewController: UIHostingController<ContentView> {
    private lazy var logger = {
        DemoLogger()
    }()

    override init(rootView: ContentView) {
        super.init(rootView: rootView)

        logger.trace(message: "trace")
        logger.debug(message: "debug")
        logger.info(message: "info")
        logger.warning(message: "warning")
        logger.error(message: "error")
        logger.critical(message: "critical")
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
