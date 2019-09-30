//
//  SennaContext.SysLog.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/9/30.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include <spdlog/sinks/syslog_sink.h>
#include "SennaContext.h"

void SennaContext::enableSysLog(const char *name, const char *pattern, const char *ident, int option, int facility, bool format) {
    auto logger = spdlog::get(name);
    if (!logger) {
        printf("logger not exist !");
        return;
    }

    auto syslog_sink = std::make_shared<spdlog::sinks::syslog_sink_mt>(ident, option, facility, format);
    syslog_sink->set_pattern(pattern);
    syslog_sink->set_level(spdlog::level::trace);

    logger->sinks().push_back(syslog_sink);
}