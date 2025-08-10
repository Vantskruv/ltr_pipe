#!/bin/sh
#LIBLINUXTRACK_FLAGS = -fpic -fPIC
#LINUXFLAGS = '-DLIB_PATH="$(pkglibdir)/"'

#liblinuxtrack_la_SOURCES = src/ltlib.c src/utils.c /src/ipc_utils.c
#liblinuxtrack_la CFLAGS = ${AM_CFLAGS} $(LIBLINUXTRACK_FLAGS) $(LINUXFLAGS)
#liblinuxtrack_la_LDFLAGS = -export-symbols src/liblt.sym ${LEOPARDS_LDFLAG}

g++ -fpic -fPIC -std=c++11 -Wall src/ltlib.c src/utils.c src/ipc_utils.c -shared -o bin/liblinuxtrack.so -export-symbols src/liblt.sym
# g++ -Wall -std=c++11 $liblinuxtrack_la_SOURCES -shared -o bin/liblinuxtrack.so


# ltlib_int pref_global cal pose tracking axis pref pathconfig dyn_load math_utils spline pref_bison pref_flex
