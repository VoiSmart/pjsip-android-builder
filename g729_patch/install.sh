#!/bin/bash -e
PJPROJECT_BASE_FOLDER="../pjproject-2.4.5"

cp g729.patch ../
CURDIR=$(pwd)
cd ..
patch -p0 < g729.patch
rm -rf g729.patch
cd "$CURDIR"

cp g729.c "$PJPROJECT_BASE_FOLDER/pjmedia/src/pjmedia-codec/g729.c"
cp g729.h "$PJPROJECT_BASE_FOLDER/pjmedia/include/pjmedia-codec/g729.h"
cp -r g729 "$PJPROJECT_BASE_FOLDER/third_party"
mkdir -p "$PJPROJECT_BASE_FOLDER/third_party/build/g729"
mv "$PJPROJECT_BASE_FOLDER/third_party/g729/Makefile" "$PJPROJECT_BASE_FOLDER/third_party/build/g729"
cd "$PJPROJECT_BASE_FOLDER"
rm -rf aconfigure
autoconf aconfigure.ac > aconfigure
sudo chmod 777 aconfigure
