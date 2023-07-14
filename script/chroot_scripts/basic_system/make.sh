#!/bin/bash

SRC_COMPRESSED_FILE=make-4.4.tar.gz
SRC_FOLDER=make-4.4

build_source_package(){
    sed -e '/ifdef SIGPIPE/,+2 d' \
	-e '/undef FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
	-i src/main.c
    ./configure --prefix=/usr
    make $MAKEFLAGS
    make install
}

