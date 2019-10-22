//
//  SennaContext.DailyFile.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/9/30.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include "SennaContext.h"
#include <spdlog/sinks/daily_file_sink.h>

void SennaContext::enableDailyFileLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *file_path, int hour, int minute) {
    auto logger = spdlog::get(name);
    if (!logger) {
        printf("logger not exist !\n");
        return;
    }

    auto daily_sink = std::make_shared<spdlog::sinks::daily_file_sink_mt>(file_path, hour, minute);
    daily_sink->set_pattern(pattern);
    daily_sink->set_level(level);

    logger->sinks().push_back(daily_sink);
}