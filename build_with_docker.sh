#!/bin/bash

docker build --tag pjsip_android:latest --file ./build.dockerfile .
CID=$(docker create pjsip_android:latest)
docker cp ${CID}:/home/output/pjsip-build-output .
docker rm ${CID}
