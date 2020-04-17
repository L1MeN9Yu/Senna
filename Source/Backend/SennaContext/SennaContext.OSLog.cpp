//
//  SennaContext.OSLog.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/10/17.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include "SennaContext.h"
#include "os_log_sink.h"

void SennaContext::enableOSLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *sub_system, const char *category, bool format) {
    auto logger = spdlog::get((const std::string &) name);
    if (!logger) {
        printf("logger not exist !\n");
        return;
    }

    auto os_log_sink = std::make_shared<senna::sinks::os_log_sink_mt>(sub_system, category, format);
    os_log_sink->set_pattern((const std::string &) pattern);
    os_log_sink->set_level(level);

    logger->sinks().push_back(os_log_sink);
}
