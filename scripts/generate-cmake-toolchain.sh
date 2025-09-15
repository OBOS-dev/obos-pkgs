#!/bin/bash
echo -e "\
set(CMAKE_SYSTEM_NAME "Linux")\n\
\n\
set(CMAKE_C_COMPILER $1-gcc)\n\
set(CMAKE_CXX_COMPILER $1-g++)\n\
\n\
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)\n\
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)\n\
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)\n\
\n\
execute_process(COMMAND ${CMAKE_C_COMPILER} -print-sysroot OUTPUT_VARIABLE CMAKE_FIND_ROOT_PATH)\n\
\n\
set(CMAKE_SHARED_LIBRARY_SONAME_C_FLAG "-Wl,-soname,")\n\
set(CMAKE_PLATFORM_USES_PATH_WHEN_NO_SONAME 1)\n\
\n\
# impersonate linux\n\
set (LINUX 1)\n\
set (WE_ARE_REALLY_OBOS ON)" > $2/toolchain.cmake
