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

void senna_add_logger(const char *name, const char *pattern) {
    Singleton<SennaContext>::sharedInstance()->createLogger(name, pattern);
}

void senna_drop_logger(const char *name) {
    Singleton<SennaContext>::sharedInstance()->dropLogger(name);
}

void senna_logger_enable_syslog(const char *name, const char *pattern, const char *ident, int option, int facility, bool format) {
    Singleton<SennaContext>::sharedInstance()->enableSysLog(name, pattern, ident, option, facility, format);
}

void senna_logger_enable_rotating_file(const char *name, const char *pattern, const char *file_path, size_t max_size, size_t max_files) {
    Singleton<SennaContext>::sharedInstance()->enableRotatingFileLog(name, pattern, file_path, max_size, max_files);
}

void senna_logger_enable_daily_file(const char *name, const char *pattern, const char *file_path, int hour, int minute) {
    Singleton<SennaContext>::sharedInstance()->enableDailyFileLog(name, pattern, file_path, hour, minute);
}
