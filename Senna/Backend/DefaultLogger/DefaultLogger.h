//
// Created by Mengyu Li on 2019/9/2.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#ifndef DEFAULT_LOGGER_H
#define DEFAULT_LOGGER_H

#ifdef __cplusplus
extern "C" {
#endif

extern const char *const default_logger_name;

extern void senna_log_trace(const char *trace_message);

extern void senna_log_debug(const char *debug_message);

extern void senna_log_info(const char *info_message);

extern void senna_log_warning(const char *warning_message);

extern void senna_log_error(const char *error_message);

extern void senna_log_critical(const char *critical_message);

#ifdef __cplusplus
};
#endif

#endif //DEFAULT_LOGGER_H
