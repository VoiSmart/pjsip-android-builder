#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

# The patch won't work on pjsip 2.10 since it would require further changes
if [ "$PJSIP_VERSION" == "2.8" ] || [ "$PJSIP_VERSION" == "2.9" ]
then
    cp g729.patch $PJPROJECT_BASE_FOLDER
else
    cp g729_old.patch $PJPROJECT_BASE_FOLDER/g729.patch
fi

CURDIR=$(pwd)
cd "$PJPROJECT_BASE_FOLDER"
patch -p0 < g729.patch
rm g729.patch
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
