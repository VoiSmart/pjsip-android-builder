#!/bin/bash
vagrant up
vagrant ssh -c "cd /pjsip-android-builder; ./build-with-g729"
