//
// Created by Mengyu Li on 2019/8/23.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation

@_silgen_name("senna_log_trace")
func c_senna_log_trace(message: UnsafePointer<Int8>?) -> Void

@_silgen_name("senna_log_debug")
func c_senna_log_debug(message: UnsafePointer<Int8>?) -> Void

@_silgen_name("senna_log_info")
func c_senna_log_info(message: UnsafePointer<Int8>?) -> Void

@_silgen_name("senna_log_warning")
func c_senna_log_warning(message: UnsafePointer<Int8>?) -> Void

@_silgen_name("senna_log_error")
func c_senna_log_error(message: UnsafePointer<Int8>?) -> Void

@_silgen_name("senna_log_critical")
func c_senna_log_critical(message: UnsafePointer<Int8>?) -> Void
