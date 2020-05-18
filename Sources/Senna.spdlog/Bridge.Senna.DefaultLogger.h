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

__attribute__((nonnull (2)))
extern void senna_default_logger_log(unsigned int flag, const char *message);

#ifdef __cplusplus
};
#endif

#endif //DEFAULT_LOGGER_H
