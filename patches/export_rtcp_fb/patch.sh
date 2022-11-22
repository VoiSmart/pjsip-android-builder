#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

cp rtcpfb.patch $PJPROJECT_BASE_FOLDER

pushd "$PJPROJECT_BASE_FOLDER"
patch -p0 < rtcpfb.patch
rm rtcpfb.patch
popd