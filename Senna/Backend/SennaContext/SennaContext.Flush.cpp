//
//  SennaContext.Flush.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/10/16.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include "SennaContext.h"

void SennaContext::flush(const char *name) {
    auto logger = spdlog::get(name);
    if (!logger) {
        printf("logger not exist !\n");
        return;
    }

    logger->flush();
}

void SennaContext::set_flush_on(const char *name, spdlog::level::level_enum level) {
    auto logger = spdlog::get(name);
    if (!logger) {
        printf("logger not exist !\n");
        return;
    }

    logger->flush_on(level);
}
