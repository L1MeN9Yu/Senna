//
//  SennaContext.Base.cpp
//  Senna
//
//  Created by Mengyu Li on 2019/9/30.
//  Copyright © 2019 Mengyu Li. All rights reserved.
//

#include <spdlog/sinks/ansicolor_sink.h>
#include <spdlog/spdlog.h>
#include "SennaContext.h"

void SennaContext::createLogger(const char *name, spdlog::level::level_enum level, const char *pattern) {
    auto stdout_sink = std::make_shared<spdlog::sinks::ansicolor_stdout_sink_mt>();
    stdout_sink->set_pattern(pattern);
    stdout_sink->set_level(level);

    std::vector<spdlog::sink_ptr> sinks;
    sinks.push_back(stdout_sink);

    auto logger = std::make_shared<spdlog::logger>(name, begin(sinks), end(sinks));
    logger->set_level(spdlog::level::trace);
    spdlog::register_logger(logger);
}

void SennaContext::dropLogger(const char *name) {
    spdlog::drop(name);
}