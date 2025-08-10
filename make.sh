#!/bin/sh
g++ -Wall -std=c++11 -DLINUX src/utils.c src/linuxtrack.c -o bin/ltr_pipe src/ltr_pipe.c
