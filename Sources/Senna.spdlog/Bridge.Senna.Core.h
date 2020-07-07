//
//  senna.h
//  Senna
//
//  Created by Mengyu Li on 2018/9/4.
//  Copyright © 2018年 Mengyu Li. All rights reserved.
//

#ifndef senna_core_h
#define senna_core_h

#include <stdio.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

__attribute__((nonnull (1, 3)))
extern void senna_add_logger(const char *name, unsigned int flag, const char *pattern);

__attribute__((nonnull (1)))
extern void senna_drop_logger(const char *name);

extern void senna_shutdown(void);

__attribute__((nonnull (1, 2, 3)))
extern void senna_spdlog_version(int *major, int *minor, int *patch);

__attribute__((nonnull (1)))
extern void senna_fmt_version(int *version);

__attribute__((nonnull (1)))
extern void senna_logger_flush(const char *name);

__attribute__((nonnull (1)))
extern void senna_logger_set_flush_on(const char *name, unsigned int flag);

__attribute__((nonnull (1, 3, 4)))
extern void senna_logger_enable_file(const char *name, unsigned int flag, const char *pattern, const char *file_path);

__attribute__((nonnull (1, 3, 4)))
extern void
senna_logger_enable_syslog(const char *name, unsigned int flag, const char *pattern, const char *ident, int option,
                           int facility, bool format);

__attribute__((nonnull (1, 3)))
extern void senna_logger_enable_oslog(const char *name, unsigned int flag, const char *pattern, const char *sub_system,
                                      const char *category, bool format);

__attribute__((nonnull (1, 3, 4)))
extern void
senna_logger_enable_rotating_file(const char *name, unsigned int flag, const char *pattern, const char *file_path,
                                  size_t max_size, size_t max_files);

__attribute__((nonnull (1, 3, 4)))
extern void
senna_logger_enable_daily_file(const char *name, unsigned int flag, const char *pattern, const char *file_path,
                               int hour, int minute);

#ifdef __cplusplus
};
#endif

#endif /* senna_core_h */
