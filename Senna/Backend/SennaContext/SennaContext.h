//
// Created by Mengyu Li on 2019/8/29.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#ifndef SENNA_CONTEXT_H
#define SENNA_CONTEXT_H

#include <spdlog/logger.h>
#include "Singleton.h"

class SennaContext {
    friend class Singleton<SennaContext>;

public:
    SennaContext();

    std::shared_ptr<spdlog::logger> logger() const {
        return this->p_default_logger;
    }

    /**
     * Create Logger,enable ansicolor_stdout
     * @param name logger name
     * @param pattern logger pattern
     */
    void createLogger(const char *name, const char *pattern);

    /**
     * 销毁一个 Logger
     * @param name logger name
     */
    void dropLogger(const char *name);

    /**
     * Enable Logger's syslog
     * @param name logger name
     * @param pattern logger pattern
     * @param ident ident
     * @param option option
     * @param facility facility
     * @param format format
     */
    void enableSysLog(const char *name, const char *pattern, const char *ident, int option, int facility, bool format);

    /**
     * Enable Logger's RotatingFileLog
     * @param name logger name
     * @param pattern logger pattern
     * @param file_path file_path
     * @param max_size max_size
     * @param max_files max_files
     */
    void enableRotatingFileLog(const char *name, const char *pattern, const char *file_path, size_t max_size, size_t max_files);

    /**
     * Enable Logger's DailyLog
     * @param name logger name
     * @param pattern logger pattern
     * @param file_path daily log file path
     * @param hour flush time hour
     * @param minute flush time minute
     */
    void enableDailyLog(const char *name, const char *pattern, const char *file_path, int hour, int minute);

private:
    std::shared_ptr<spdlog::logger> p_default_logger;

    virtual ~SennaContext() {
    }
};

#endif //SENNA_CONTEXT_H
