//
// Created by Mengyu Li on 2019/9/2.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#include "DefaultLogger.h"
#include "SennaContext.h"

void senna_log_trace(const char *trace_message) {
    Singleton<SennaContext>::sharedInstance()->logger()->trace(trace_message);
}

void senna_log_debug(const char *debug_message) {
    Singleton<SennaContext>::sharedInstance()->logger()->debug(debug_message);
}

void senna_log_info(const char *info_message) {
    Singleton<SennaContext>::sharedInstance()->logger()->info(info_message);
}

void senna_log_warning(const char *warning_message) {
    Singleton<SennaContext>::sharedInstance()->logger()->warn(warning_message);
}

void senna_log_error(const char *error_message) {
    Singleton<SennaContext>::sharedInstance()->logger()->error(error_message);
}

void senna_log_critical(const char *critical_message) {
    Singleton<SennaContext>::sharedInstance()->logger()->critical(critical_message);
}