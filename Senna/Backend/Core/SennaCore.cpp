//
//  senna.c
//  Senna
//
//  Created by Mengyu Li on 2018/9/4.
//  Copyright © 2018年 Mengyu Li. All rights reserved.
//

#include "SennaCore.h"
#include "Singleton.h"
#include "SennaContext.h"

void senna_add_logger(const char *name, unsigned int flag, const char *pattern) {
    spdlog::level::level_enum level = spdlog::level::level_enum(flag); 
    Singleton<SennaContext>::sharedInstance()->createLogger(name, level, pattern);
}

void senna_drop_logger(const char *name) {
    Singleton<SennaContext>::sharedInstance()->dropLogger(name);
}

void senna_logger_enable_syslog(const char *name, unsigned int flag, const char *pattern, const char *ident, int option, int facility, bool format) {
    spdlog::level::level_enum level = spdlog::level::level_enum(flag);
    Singleton<SennaContext>::sharedInstance()->enableSysLog(name, level, pattern, ident, option, facility, format);
}

void senna_logger_enable_rotating_file(const char *name, unsigned int flag, const char *pattern, const char *file_path, size_t max_size, size_t max_files) {
    spdlog::level::level_enum level = spdlog::level::level_enum(flag);
    Singleton<SennaContext>::sharedInstance()->enableRotatingFileLog(name, level, pattern, file_path, max_size, max_files);
}

void senna_logger_enable_daily_file(const char *name, unsigned int flag, const char *pattern, const char *file_path, int hour, int minute) {
    spdlog::level::level_enum level = spdlog::level::level_enum(flag);
    Singleton<SennaContext>::sharedInstance()->enableDailyFileLog(name, level, pattern, file_path, hour, minute);
}
