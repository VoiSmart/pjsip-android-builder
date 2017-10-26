# Version Update

To use the updated version of the builder, substitute the files:
* config.conf
* prepare-build-system
* build-with-g729

in the main directory, and
* g729.patch

from the g729_patch directory, with the ones included in the version_update directory.

## config.conf
* NDK updated to version r15c
* SDK updated to version 25.2.3
* PJSIP updated to version 2.7
* SWIG updated to version 3.0.12
* OPENH264 updated to version 1.6.0
* OPENH264_NDK_TARGET_VERSION updated to API 23
* TARGET_ARCHS added 64bit archs (except for mips)
* ANDROIDD_APIS 23 and 25
* BUILD_TOOLS updated to API 25
* TARGET_ANDROID_API updated to API 23

## prepare_build_system
* Forced use of GCC compiler instead of Clang (NDK default) because it is still conflicts somehow with pjsip
* Use of unzip instead of tar (Google releases its SDKs only in zip format)
* Fix for pjsip 2.4.5 no longer needed -> g729 patch broght outside the pjsip version IF

## build-with-g729
changes have been made only to the g729 build version, you can easily apply them to the other build files.
* path fixing

## g729.patch
* path fixing (pjproject 2.4.5 > 2.7)

## install.sh
* path fixing (pjproject 2.4.5 > 2.7)
