//
// Created by Mengyu Li on 2019/10/17.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

#pragma once

#include <mutex>
#include <string>
#include <spdlog/spdlog.h>
#include <spdlog/sinks/base_sink.h>
#include "spdlog/details/null_mutex.h"
#include <os/log.h>

namespace senna {
    namespace sinks {
        template<typename Mutex>
        class os_log_sink final : public spdlog::sinks::base_sink<Mutex> {
        public:
            os_log_sink(std::string sub_system, std::string category, bool format = false) {
                p_os_logger = ::os_log_create(
                        sub_system.empty() ? nullptr : sub_system.c_str(),
                        category.empty() ? nullptr : category.c_str()
                );
                enable_format = format;
            }

        protected:
            void sink_it_(const spdlog::details::log_msg &msg) override {
                os_log_type_t os_log_type = OS_LOG_TYPE_DEFAULT;
                switch (msg.level) {
                    case spdlog::level::trace:
                        os_log_type = os_log_debug_enabled(p_os_logger) ? OS_LOG_TYPE_DEBUG : OS_LOG_TYPE_INFO;
                        break;
                    case spdlog::level::debug:
                        os_log_type = os_log_debug_enabled(p_os_logger) ? OS_LOG_TYPE_DEBUG : OS_LOG_TYPE_INFO;
                        break;
                    case spdlog::level::info:
                        os_log_type = OS_LOG_TYPE_INFO;
                        break;
                    case spdlog::level::warn:
                        os_log_type = OS_LOG_TYPE_DEFAULT;
                        break;
                    case spdlog::level::err:
                        os_log_type = OS_LOG_TYPE_ERROR;
                        break;
                    case spdlog::level::critical:
                        os_log_type = OS_LOG_TYPE_FAULT;
                        break;
                    case spdlog::level::off:
                    case spdlog::level::n_levels:
                        return;
                }

                if (enable_format) {
                    spdlog::memory_buf_t formatted;
                    spdlog::sinks::base_sink<Mutex>::formatter_->format(msg, formatted);

                    os_log_with_type(p_os_logger, os_log_type, "%{public}s", fmt::to_string(formatted).c_str());
                } else {
                    os_log_with_type(p_os_logger, os_log_type, "%{public}s", msg.payload.data());
                }
            }

            void flush_() override {
            }

        private:
            os_log_t p_os_logger;
            bool enable_format = false;
        };

        using os_log_sink_mt = os_log_sink<std::mutex>;
        using os_log_sink_st = os_log_sink<spdlog::details::null_mutex>;
    }
}
