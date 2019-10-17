//
// Created by Mengyu Li on 2019/8/29.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#ifndef SENNA_CONTEXT_H
#define SENNA_CONTEXT_H

#include <spdlog/logger.h>
#include "Senna.Singleton.h"

class SennaContext {
    friend class Singleton<SennaContext>;

public:
    std::shared_ptr<spdlog::logger> logger() const {
        return this->p_default_logger;
    }

    /**
     * Create Logger,enable ansicolor_stdout
     * @param name logger name
     * @param pattern logger pattern
     */
    void createLogger(const char *name, spdlog::level::level_enum level, const char *pattern);

    /**
     * Drop the Logger
     * @param name logger name
     */
    void dropLogger(const char *name);

    /**
     * Logger manual flush
     * @param name logger name
     */
    void flush(const char *name);

    /**
     * Set Logger auto flush level
     * @param name logger name
     * @param level flush level
     */
    void set_flush_on(const char *name, spdlog::level::level_enum level);

    /**
     * Enable Logger's fileLog
     * @param name logger name
     * @param level logger level
     * @param pattern logger pattern
     * @param file_path file_path
     */
    void enableFileLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *file_path);

    /**
     * Enable Logger's syslog
     * @param name logger name
     * @param level logger level
     * @param pattern logger pattern
     * @param ident ident
     * @param option option
     * @param facility facility
     * @param format is format
     */
    void enableSysLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *ident, int option, int facility, bool format);

    /**
     * Enable Logger's OSLog
     * @param name logger name
     * @param level logger level
     * @param pattern logger pattern
     * @param sub_system os log sub system
     * @param category os log category
     * @param format is format
     */
    void enableOSLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *sub_system, const char *category, bool format);

    /**
     * Enable Logger's RotatingFileLog
     * @param name logger name
     * @param pattern logger pattern
     * @param file_path file_path
     * @param max_size max_size
     * @param max_files max_files
     */
    void enableRotatingFileLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *file_path, size_t max_size, size_t max_files);

    /**
     * Enable Logger's DailyLog
     * @param name logger name
     * @param pattern logger pattern
     * @param file_path daily log file path
     * @param hour flush time hour
     * @param minute flush time minute
     */
    void enableDailyFileLog(const char *name, spdlog::level::level_enum level, const char *pattern, const char *file_path, int hour, int minute);

    void shutDown(void);

private:
    std::shared_ptr<spdlog::logger> p_default_logger;

    SennaContext();

    virtual ~SennaContext() {
    }
};

#endif //SENNA_CONTEXT_H
