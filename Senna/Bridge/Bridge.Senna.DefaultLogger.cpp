//
// Created by Mengyu Li on 2019/9/2.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#include "Bridge.Senna.DefaultLogger.h"
#include "SennaContext.h"

void senna_default_logger_log(unsigned int flag, const char *message) {
    spdlog::level::level_enum level = spdlog::level::level_enum(flag);
    Singleton<SennaContext>::sharedInstance()->logger()->log(level, message);
}
