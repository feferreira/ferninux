#!/bin/bash

PACKAGE_NAME="kidletime"
VERSION="5.109.0"
DOWNLOAD_URL="https://download.kde.org/stable/frameworks/5.109/kidletime-5.109.0.tar.xz"
MD5_SUM="d8f87c99c0b798f04ac328d7050d2d97"
SRC_COMPRESSED_FILE=$(echo $DOWNLOAD_URL | rev | cut -d '/' -f 1 | rev)
SRC_FOLDER=$PACKAGE_NAME-$VERSION

build_source_package(){
   cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX      \
              -DCMAKE_PREFIX_PATH=$QT5DIR         \
              -DCMAKE_BUILD_TYPE=Release          \
              -DBUILD_TESTING=OFF                 \
              -Wno-dev ..
      make $MAKEFLAGS
      make install
      /sbin/ldconfig
}