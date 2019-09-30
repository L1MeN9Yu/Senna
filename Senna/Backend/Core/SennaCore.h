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

extern void senna_add_logger(const char *name, unsigned int flag, const char *pattern);

extern void senna_drop_logger(const char *name);

extern void senna_logger_enable_syslog(const char *name, unsigned int flag, const char *pattern, const char *ident, int option, int facility, bool format);

extern void senna_logger_enable_rotating_file(const char *name, unsigned int flag, const char *pattern, const char *file_path, size_t max_size, size_t max_files);

extern void senna_logger_enable_daily_file(const char *name, unsigned int flag, const char *pattern, const char *file_path, int hour, int minute);

#ifdef __cplusplus
};
#endif

#endif /* senna_core_h */
