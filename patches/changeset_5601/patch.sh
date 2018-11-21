#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

cp changeset_5601.patch $PJPROJECT_BASE_FOLDER

CURDIR=$(pwd)
cd "$PJPROJECT_BASE_FOLDER"
patch -p0 < changeset_5601.patch
rm changeset_5601.patch
cd "$CURDIR"