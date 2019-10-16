//
//  SennaContext.FileLog.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/10/16.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include "SennaContext.h"
#include <spdlog/sinks/basic_file_sink.h>

void SennaContext::enableFileLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *file_path) {
    auto logger = spdlog::get(name);
    if (!logger) {
        printf("logger not exist !\n");
        return;
    }

    auto file_sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(file_path);
    file_sink->set_pattern(pattern);
    file_sink->set_level(level);

    logger->sinks().push_back(file_sink);
}