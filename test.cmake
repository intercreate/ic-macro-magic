# Copyright (c) 2023, Intercreate, Inc.
# SPDX-License-Identifier: Apache-2.0
#
# Automate CMake configure, build, and test.
#
# Instead of:
#   
#   cmake -B build && cmake --build build --clean-first && ctest --test-dir build/tests -V
# 
# Use:
#
#   cmake -P test.cmake
#

execute_process(
    COMMAND cmake "-Bbuild"
    RESULT_VARIABLE res 
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
if(NOT ${res} STREQUAL "0")
    message(FATAL_ERROR "CMake configuration step failed.")
endif()

execute_process(
    COMMAND cmake "--build" "build" "--clean-first"
    RESULT_VARIABLE res
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
if(NOT ${res} STREQUAL "0")
    message(FATAL_ERROR "CMake build step failed.")
endif()

execute_process(COMMAND ctest "-V" "--test-dir" "build/tests"
    RESULT_VARIABLE res
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
if(NOT ${res} STREQUAL "0")
    message(FATAL_ERROR "1 or more tests failed.")
endif()
