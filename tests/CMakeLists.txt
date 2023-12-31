# SPDX-License-Identifier: Apache-2.0
#
# Copyright (c) 2023 Intercreate, Inc.
# Author: J.P. Hutchins <jp@intercreate.io>

enable_testing()

include(FetchContent)
FetchContent_Declare(
    unity
    GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity.git
    GIT_TAG 1b9199ee380e203603b6649df9510db9cab147d9
)
FetchContent_MakeAvailable(unity)

# Collect the test folders
file(GLOB tests RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "test_*")
message(STATUS "Collected tests [ ${tests} ]")

# Build each test and add it to CTest
foreach(test ${tests})
    project(${test})    
    file(GLOB_RECURSE src_files ${CMAKE_CURRENT_SOURCE_DIR}/${test}/*.c)
    message(STATUS "${test} src_files [ ${src_files} ]")
    add_executable(${test} ${src_files})
    target_link_libraries(${test} unity)
    add_test(${test} ${test})
endforeach()
