//
// Created by Mengyu Li on 2019/9/3.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#include "LogAction.h"
#include <spdlog/spdlog.h>

void senna_log_action(const char *logger_name, unsigned int flag, const char *message) {
    auto logger = spdlog::get(logger_name);
    if (!logger){
        printf("logger not exist !! \n");
        return;
    }
    spdlog::level::level_enum level = spdlog::level::level_enum(flag);
    logger->log(level, message);
}
