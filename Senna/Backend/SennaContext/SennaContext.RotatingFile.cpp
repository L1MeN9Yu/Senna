//
//  SennaContext.RotatingFile.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/9/30.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/spdlog.h>
#include <spdlog/sinks/rotating_file_sink.h>
#include "SennaContext.h"

void SennaContext::enableRotatingFileLog(const char *name, const char *pattern, const char *file_path, size_t max_size, size_t max_files) {
    auto logger = spdlog::get(name);
    if (!logger) {
        printf("logger not exist !");
        return;
    }

    auto rotating_sink = std::make_shared<spdlog::sinks::rotating_file_sink_mt>(file_path, max_size, max_files);
    rotating_sink->set_pattern(pattern);
    rotating_sink->set_level(spdlog::level::trace);

    logger->sinks().push_back(rotating_sink);
}