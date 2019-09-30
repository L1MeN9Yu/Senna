//
//  SennaContext.DailyFile.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/9/30.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include <spdlog/sinks/daily_file_sink.h>
#include "SennaContext.h"

void SennaContext::enableDailyLog(const char *name, const char *pattern, const char *file_path, int hour, int minute) {
    auto logger = spdlog::get(name);
    if (!logger) {
        printf("logger not exist !");
        return;
    }

    auto daily_sink = std::make_shared<spdlog::sinks::daily_file_sink_mt>(file_path, hour, minute);
    daily_sink->set_pattern(pattern);
    daily_sink->set_level(spdlog::level::trace);

    logger->sinks().push_back(daily_sink);
}