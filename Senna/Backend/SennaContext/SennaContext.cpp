//
// Created by Mengyu Li on 2019/8/29.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#include "SennaContext.h"
#include "SennaCore.h"
#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/sinks/rotating_file_sink.h>
#include <spdlog/sinks/syslog_sink.h>
#include <spdlog/sinks/daily_file_sink.h>
#include <spdlog/common.h>
#include <iostream>

const char *const default_logger_name = "Senna";

SennaContext::SennaContext() {
    setenv("TERM", "color", 1);
    spdlog::set_error_handler([](const std::string &msg) {
        std::cerr << "senna core error : " << msg << std::endl;
    });

    p_default_logger = spdlog::stdout_color_mt(default_logger_name);
    p_default_logger->set_pattern("[%D %T] [%=10n] %^[process id : %P] [thread id : %t] [%8l] %v%$");
    p_default_logger->set_level(spdlog::level::trace);
    p_default_logger->info("spdlog version {}.{}.{} !", SPDLOG_VER_MAJOR, SPDLOG_VER_MINOR, SPDLOG_VER_PATCH);
    p_default_logger->info("fmt version {} !", FMT_VERSION);
    spdlog::set_default_logger(p_default_logger);
}

void SennaContext::createLogger(const char *name, const char *pattern) {
    auto stdout_sink = std::make_shared<spdlog::sinks::ansicolor_stdout_sink_mt>();
    stdout_sink->set_pattern(pattern);
    stdout_sink->set_level(spdlog::level::trace);

    std::vector<spdlog::sink_ptr> sinks;
    sinks.push_back(stdout_sink);

    auto logger = std::make_shared<spdlog::logger>(name, begin(sinks), end(sinks));
    logger->set_level(spdlog::level::trace);
    spdlog::register_logger(logger);
}

void SennaContext::dropLogger(const char *name) {
    spdlog::drop(name);
}

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
