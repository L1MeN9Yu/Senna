//
// Created by Mengyu Li on 2019/9/3.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#ifdef __cplusplus
extern "C" {
#endif

__attribute__((nonnull (1, 3)))
extern void senna_log_action(const char *logger_name, unsigned int flag, const char *message);

#ifdef __cplusplus
};
#endif
