#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

PATCH_NAME=fix_missing_contact_header.patch

cp $PATCH_NAME $PJPROJECT_BASE_FOLDER

pushd "$PJPROJECT_BASE_FOLDER"
patch -p0 < $PATCH_NAME
rm $PATCH_NAME
popd