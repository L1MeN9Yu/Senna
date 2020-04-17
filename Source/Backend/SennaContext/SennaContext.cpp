//
// Created by Mengyu Li on 2019/8/29.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#include "SennaContext.h"
#include "Bridge.Senna.Core.h"
#include <spdlog/spdlog.h>
#include <iostream>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <os/log.h>

const char *const default_logger_name = "Senna";

SennaContext::SennaContext() {
    setenv("TERM", "color", 1);
    spdlog::set_error_handler([](const std::string &msg) {
        std::cerr << "senna core error : " << msg << std::endl;
    });

    p_default_logger = spdlog::stdout_color_mt((const std::string &) default_logger_name);
    p_default_logger->set_pattern((const std::string &) "[%D %T] [%=10n] %^[pid : %P] [tid : %t] [%1L] %v%$");
    p_default_logger->set_level(spdlog::level::trace);
    p_default_logger->trace("Senna Start Succeed ! [spdlog version {}.{}.{} !] [fmt version {} !]", SPDLOG_VER_MAJOR, SPDLOG_VER_MINOR, SPDLOG_VER_PATCH, FMT_VERSION);
    spdlog::set_default_logger(p_default_logger);
}
