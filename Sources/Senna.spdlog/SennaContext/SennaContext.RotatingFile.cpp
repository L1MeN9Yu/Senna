//
//  SennaContext.RotatingFile.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/9/30.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include "SennaContext.h"
#include <spdlog/sinks/rotating_file_sink.h>

void SennaContext::enableRotatingFileLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *file_path, size_t max_size, size_t max_files) {
    auto logger = spdlog::get((const std::string &) name);
    if (!logger) {
        printf("logger not exist !\n");
        return;
    }

    auto rotating_sink = std::make_shared<spdlog::sinks::rotating_file_sink_mt>(file_path, max_size, max_files);
    rotating_sink->set_pattern((const std::string &) pattern);
    rotating_sink->set_level(level);

    logger->sinks().push_back(rotating_sink);
}