#=============================================================
#  LinuxTrack – CMake build file
#=============================================================
cmake_minimum_required(VERSION 3.10)

# The project uses both C and C++ source files
project(LinuxTrack LANGUAGES C CXX)

#------------------------------------------------------------------
# Standard language flags (the same as -std=c++11 – and -std=c99 for C)
#------------------------------------------------------------------
set(CMAKE_C_STANDARD   99)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(LIB_PATH ".")

#------------------------------------------------------------------
# Source file list
#------------------------------------------------------------------
set(SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

set(SOURCES
    ${SRC_DIR}/ipc_utils.c
    ${SRC_DIR}/ltlib.c
    ${SRC_DIR}/ltlib_int.c
    ${SRC_DIR}/axis.c
    ${SRC_DIR}/cal.c
    ${SRC_DIR}/dyn_load.c
    ${SRC_DIR}/math_utils.c
    ${SRC_DIR}/pose.c
    ${SRC_DIR}/pref.cpp
    ${SRC_DIR}/pref_bison.cpp
    ${SRC_DIR}/pref_flex.cpp
    ${SRC_DIR}/spline.c
    ${SRC_DIR}/tracking.c
		${SRC_DIR}/pref_global.c
		${SRC_DIR}/utils.c
)

#------------------------------------------------------------------
# Build the shared library
#------------------------------------------------------------------
add_library(liblinuxtrack SHARED ${SOURCES})

target_include_directories(liblinuxtrack PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# Make the library PIC – CMake does this automatically for SHARED
# but we set it explicitly for clarity
set_target_properties(liblinuxtrack PROPERTIES
    POSITION_INDEPENDENT_CODE ON          # -fPIC
    PREFIX ""                             # no leading 'lib' will be added
    OUTPUT_NAME liblinuxtrack                # produces liblinuxtrack.so
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

# Compiler flags (equivalent to -Wall in the command line)
target_compile_options(liblinuxtrack PRIVATE -Wall)

# If any header files are required during compilation, add the
# directory containing them.  Adjust if your headers live elsewhere.
target_include_directories(liblinuxtrack PRIVATE ${SRC_DIR})

target_compile_definitions(liblinuxtrack PRIVATE HAVE_CONFIG_H)
target_compile_definitions(liblinuxtrack PRIVATE "LIB_PATH=\"${LIB_PATH}\"")

# -------------------------------------------------------------------
#  2. Executable: ltr_pipe
# -------------------------------------------------------------------

#  Sources for the executable – only the files you mentioned
set(EXE_SOURCES
		${SRC_DIR}/ltr_pipe.c
		${SRC_DIR}/linuxtrack.c
		${SRC_DIR}/utils.c      # note: the same utils.c that the lib also uses
)

add_executable(ltr_pipe ${EXE_SOURCES})

target_include_directories(ltr_pipe PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# Optional: set properties for the exe (same as above)
target_compile_options(ltr_pipe PRIVATE -Wall)
target_include_directories(ltr_pipe PRIVATE ${EXE_DIR})

target_compile_definitions(ltr_pipe PRIVATE LINUX)
target_compile_definitions(ltr_pipe PRIVATE HAVE_CONFIG_H)
target_compile_definitions(ltr_pipe PRIVATE "LIB_PATH=\"${LIB_PATH}\"")


# -------------------------------------------------------------------
#  Optional: installation (if you want to install both targets)
# -------------------------------------------------------------------
# install(TARGETS linuxtrack ltr_pipe
#   LIBRARY DESTINATION lib
#   RUNTIME DESTINATION bin
# )

