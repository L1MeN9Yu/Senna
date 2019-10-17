//
// Created by Mengyu Li on 2019/9/3.
// Copyright (c) 2019 Mengyu Li. All rights reserved.
//

import Foundation

@_silgen_name("senna_add_logger")
func senna_add_logger(_ name: UnsafePointer<Int8>, _ flag: UInt32, _ pattern: UnsafePointer<Int8>)

@_silgen_name("senna_drop_logger")
func senna_drop_logger(_ name: UnsafePointer<Int8>)

@_silgen_name("senna_shutdown")
func senna_shutdown()

@_silgen_name("senna_logger_flush")
func senna_logger_flush(_ name: UnsafePointer<Int8>)

@_silgen_name("senna_logger_set_flush_on")
func senna_logger_set_flush_on(_ name: UnsafePointer<Int8>, _ flag: UInt32)

@_silgen_name("senna_logger_enable_file")
func senna_logger_enable_file(_ name: UnsafePointer<Int8>, _ flag: UInt32, _ pattern: UnsafePointer<Int8>, _ file_path: UnsafePointer<Int8>)

@_silgen_name("senna_logger_enable_syslog")
func senna_logger_enable_syslog(_ name: UnsafePointer<Int8>, _ flag: UInt32, _ pattern: UnsafePointer<Int8>, _ ident: UnsafePointer<Int8>, _ option: CInt, _ facility: CInt, _ format: Bool)

@_silgen_name("senna_logger_enable_oslog")
func senna_logger_enable_oslog(_ name: UnsafePointer<Int8>, _ flag: UInt32, _ pattern: UnsafePointer<Int8>, _ sub_system: UnsafePointer<Int8>?, _ category: UnsafePointer<Int8>?)

@_silgen_name("senna_logger_enable_rotating_file")
func senna_logger_enable_rotating_file(_ name: UnsafePointer<Int8>, _ flag: UInt32, _ pattern: UnsafePointer<Int8>, _ file_path: UnsafePointer<Int8>, _ max_size: Int, _ max_files: Int)

@_silgen_name("senna_logger_enable_daily_file")
func senna_logger_enable_daily_file(_ name: UnsafePointer<Int8>, _ flag: UInt32, _ pattern: UnsafePointer<Int8>, _ file_path: UnsafePointer<Int8>, _ hour: CInt, _ minute: CInt)