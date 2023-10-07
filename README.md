# Intercreate Macro Magic

This header-only macro library provides useful macros for code generation.

# Generate Strings for Enums

Imagine that you have some enum in your project and would like to print it as strings rather than
as enumerated values.  `ic_macro_magic` provides this capability without any code repetition.

### `faddle_errors.h`

```c
#pragma once

#include "ic_macro_magic.h"

/* First, declare your enum namespace and list. */

#define _FADDLE_ERRORS_LIST IC_PREFIXES_FOR(FADDLE_ERROR, \
    THNEED, \
    MIFF, \
    SNUVV, \
    LERKIM, \
    GLUNK, \
    DOOKLAS, \
    VOOM
)

/* Now, define the enum type. */

enum faddle_errors { IC_ENUMS_FOR(0x80, _FADDLE_ERRORS_LIST) };

/* Now the enum faddle_errors has FADDLE_ERROR_THNEED = 0x80, FADDLE_ERROR_MIFF = 0x81, etc. 
 * Next, declare the string map. */

extern char const * const _FADDLE_ERRORS_STRINGS[];

/* This will get defined in faddle_errors.c.  Create the convenience macro that will convert
 * the enums to strings. */

#define FADDLE_ERROR_STRING(enum) \
    IC_MAKE_STRING_GETTER(enum, _FADDLE_ERRORS_STRINGS, _FADDLE_ERRORS_LIST)
```

### `faddle_errors.c`

```c
#include "faddle_errors.h"

char const * const _FADDLE_ERRORS_STRINGS[] = {IC_STRING_MAP_FOR(_FADDLE_ERRORS_LIST)};
/* _FADDLE_ERRORS_STRINGS is now defined as
 *  {
 *      "FADDLE_ERROR_THNEED",
 *      "FADDLE_ERROR_MIFF",
 *      ...    
 *  };
 */
```

### `some_other_source.c`

```c
#include "faddle_errors.h"

int err = update_faddle(nooronetics);
if (err != 0) {
    printf("check_faddle(%d) returned %s\n", nooronetics, FADDLE_ERROR_STRING(err));
}
```
The above example would print `"check_faddle(42) returned FADDLE_ERROR_DOOKLAS"` if the error
was `0x85`.

# Import to your CMake build

The easiest way to use this library in your project is to use CMake's [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html) API.

```cmake
include(FetchContent)

FetchContent_Declare(ic_macro_magic
    URL https://github.com/intercreate/ic-macro-magic/releases/latest/download/ic_macro_magic.zip
)
FetchContent_MakeAvailable(ic_macro_magic)

target_link_libraries(my_cmake_project ic_macro_magic)
```

You can pin to a version by using the URL from the release page, e.g. https://github.com/intercreate/ic-macro-magic/releases/download/0.1.0/ic_macro_magic.zip, instead of "latest".

# Tests

`cmake -P test.cmake`

# Lint

`cmake -P lint.cmake`

# Format

`cmake -P lint.cmake format`
