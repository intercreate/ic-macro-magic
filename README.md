# Intercreate Macro Magic

This header-only macro library provides useful macros for code generation.

# Import to your CMake build

The easiest way to use this library in your project is to use CMake's [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html) API.

```cmake
include(FetchContent)

FetchContent_Declare(ic_macro_magic
    URL https://github.com/intercreate/ic-macro-magic/releases/download/latest/ic_macro_magic.zip
)
FetchContent_MakeAvailable(ic_macro_magic)

target_link_libraries(my_cmake_project ic_macro_magic)
```

You can pin to a version by using the URL from the release page, e.g. https://github.com/intercreate/ic-macro-magic/releases/download/0.1.0/ic_macro_magic.zip, instead of "latest".

# Tests

`cmake -P tests/test.cmake`

# Lint

`cmake -P lint.cmake`

# Format

`cmake -P lint.cmake format`
