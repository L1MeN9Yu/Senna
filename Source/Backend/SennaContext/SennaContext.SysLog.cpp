//
//  SennaContext.SysLog.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/9/30.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include "SennaContext.h"
#include <spdlog/sinks/syslog_sink.h>

void SennaContext::enableSysLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *ident, int option, int facility, bool format) {
    auto logger = spdlog::get((const std::string &) name);
    if (!logger) {
        printf("logger not exist !\n");
        return;
    }

    auto syslog_sink = std::make_shared<spdlog::sinks::syslog_sink_mt>(ident, option, facility, format);
    syslog_sink->set_pattern((const std::string &) pattern);
    syslog_sink->set_level(level);

    logger->sinks().push_back(syslog_sink);
}