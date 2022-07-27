#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

if [ "${IS_PJSIP_LOWER_THAN_2_11}" == "1" ]
then
  cp callid.old.patch $PJPROJECT_BASE_FOLDER/callid.patch
else
  cp callid.patch $PJPROJECT_BASE_FOLDER
fi

CURDIR=$(pwd)
cd "$PJPROJECT_BASE_FOLDER"
patch -p0 < callid.patch
rm callid.patch

cd "$CURDIR"
