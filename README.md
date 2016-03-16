# PJSIP Android Builder
Easily build PJSIP with: OpenSSL, OpenH264, libyuv and G.729 (without Intel IPP) for Android, by using a Linux virtual machine.

| Library \ Builds for | armeabi | armeabi-v7a | x86 | mips | arm64-v8a  | x86_64 | mips64 |
|----------------------|---------|-------------|-----|------|------------|--------|--------|
| [PJSIP 2.4.5](https://trac.pjsip.org/repos/browser/pjproject/tags/2.4.5)          |    X    |      X      |  X  |   X  |      X     |    X   |    X   |
| [LibYUV r1255](https://github.com/illuspas/libyuv-android)         |    X    |      X      |  X  |   X  |      X     |    X   |    X   |
| [G.729](https://github.com/gotev/pjsip-android-builder/tree/master/g729_patch)                |    X    |      X      |  X  |   X  |      X     |    X   |    X   |
| [OpenSSL 1.0.2g](https://www.openssl.org/source/)       |    X    |      X      |  X  |   X  |      X     |    X   |        |
| [OpenH264 1.0.0](https://github.com/cisco/openh264/releases/tag/v1.0.0)       |    X    |      X      |  X  |   X  |            |        |        |

Using Android API 21 and GCC 4.8. If you want to extend build support, fork the project and then send me a pull request.

OpenSSL and OpenH264 have problems with 64 bit archs, as you can see from the build compatibility matrix. Check [#2](https://github.com/gotev/pjsip-android-builder/issues/2) and [#8](https://github.com/gotev/pjsip-android-builder/issues/8) for further reference. 64 bit builds are supported starting from Android API 21+, so if you compile using older Android APIs, you can do that only for: `armeabi`, `armeabi-v7a`, `x86` and `mips`. 

## Purpose
I needed an easily replicable build system to build PJSIP http://www.pjsip.org/ native library with NDK for Android. So, I created a Linux virtual machine and wrote some scripts to download, install all the requirements needed to make it a complete build environment and some automated build scripts.
If you want to contribute, your help is really appreciated :)

## Easy setup
Install [vagrant](https://www.vagrantup.com/), then open a terminal and execute:
```
git clone https://github.com/gotev/pjsip-android-builder
cd pjsip-android-builder
vagrant up
```
This will setup a full Ubuntu Server 14.04.3 LTS from scratch with everything that's needed to compile PJSIP. This will take some time, as there are many things which has to be downloaded and installed, so relax or do some other thing while waiting. After plenty of output, if everything is ok you will see:
```
The build system is ready! Execute: ./build to build PJSIP :)
```
then you can SSH into the VM and build PJSIP:
```
vagrant ssh
cd /pjsip-android-builder
./build
```

## Manual setup
First, you need a virtualization system. There are plenty of choices out there. Choose the one that you prefer (VirtualBox, vmWare, Vagrant, you name it). I'm supposing that you know what a virtual machine is and how to setup your environment to be able to run virtual machines. So, let's begin :)

1. Download the latest Ubuntu Server ISO (I've chosen 14.04.3 LTS): http://www.ubuntu.com/download/server <br>I've chosen this distro because it has a good support for the applications that we need and it's kept updated. In the future, support to other distributions can be added as well, with your help :)
2. Create a new virtual machine with at least 1GB RAM and 20GB virtual hard drive. Add as many RAM and processors as you can, so the compilation process will be faster.
3. Install Ubuntu Server
4. SSH into your newly installed VM and execute the following commands, which will install all the required packages and files to be able to build PJSIP. This will take some time, as there are many things which has to be downloaded and installed, so relax or do some other thing while waiting<br>
```
sudo apt-get install -y git
git clone https://github.com/alexbbb/pjsip-android-builder
cd pjsip-android-builder
./prepare-build-system
```

## Build PJSIP
After you have successfully set up your VM, to build PJSIP, go into pjsip-android-builder and execute:
```
./build
```
When everything goes well, you will see an output like this:
```
Clear final build folder ...
Creating config site file for Android ...
Compile PJSIP for arch armeabi ...
Compile PJSUA for arch armeabi ...
Copying PJSUA .so library to final build directory ...
Copying OpenH264 .so library to final build directory ...
Copying libyuv .so library to final build directory ...
Compile PJSIP for arch armeabi-v7a ...
Compile PJSUA for arch armeabi-v7a ...
Copying PJSUA .so library to final build directory ...
Copying OpenH264 .so library to final build directory ...
Copying libyuv .so library to final build directory ...
Compile PJSIP for arch x86 ...
Compile PJSUA for arch x86 ...
Copying PJSUA .so library to final build directory ...
Copying OpenH264 .so library to final build directory ...
Copying libyuv .so library to final build directory ...
Compile PJSIP for arch x86_64 ...
Compile PJSUA for arch x86_64 ...
Copying PJSUA .so library to final build directory ...
Copying libyuv .so library to final build directory ...
Compile PJSIP for arch arm64-v8a ...
Compile PJSUA for arch arm64-v8a ...
Copying PJSUA .so library to final build directory ...
Copying libyuv .so library to final build directory ...
Copying PJSUA2 java bindings to final build directory ...
Finished! Check the generated output in /home/user/pjsip-android-builder/pjsip-build
```

The script is going to create a new folder named <b>pjsip-build</b> organized as follows:
```
pjsip-build
 |-- logs/  contains the full build log for each target architecture
 |-- lib/   contains the compiled libraries for each target architecture
 |-- src/   contains PJSUA Java wrapper to work with the library
```
If something goes wrong during the compilation of a particular target architecture, the main script will be terminated and you can see the full log in `./pjsip-build/logs/<arch>.log`. So for example if there's an error for <b>x86</b>, you can see the full log in `./pjsip-build/logs/x86.log`

## Build with G.729 codec
Please read [G.729 codec disclaimer](https://github.com/gotev/pjsip-android-builder/blob/master/g729_patch/README.md)!

Use `./build-with-g729` script insted of `./build`.

## Configuration
It's possible to configure library versions and build settings by editing the <b>config.conf</b> file. Please read the comments in the file for more details.

## Build only OpenSSL
This project has separate independent script to build only OpenSSL library.
```
Usage:
./openssl-build <ANDROID_NDK_PATH> <OPENSSL_SOURCES_PATH> <ANDROID_TARGET_API> \
                <ANDROID_TARGET_ABI> <GCC_VERSION> <OUTPUT_PATH>

Supported target ABIs: armeabi, armeabi-v7a, x86, x86_64, arm64-v8a

Example using GCC 4.8, NDK 10e, OpenSSL 1.0.2d and Android API 21 for armeabi-v7a.
./openssl-build /home/user/android-ndk-r10e /home/user/openssl-1.0.2d 21 \
                armeabi-v7a 4.8 /home/user/output/armeabi-v7a
```
If you want to leverage on the <b>config.conf</b> properties and build OpenSSL for every configured target arch, you can use the following helper script:
```
./openssl-build-target-archs
```
When everything goes well, you will see an output like this:
```
Building OpenSSL for target arch armeabi ...
Building OpenSSL for target arch armeabi-v7a ...
Building OpenSSL for target arch x86 ...
Building OpenSSL for target arch x86_64 ...
Building OpenSSL for target arch arm64-v8a ...
Finished building OpenSSL! Check output folder: /home/user/pjsip-android-builder/openssl-build-output
```
The script is going to create a new folder named <b>openssl-build-output</b> organized as follows:
```
openssl-build-output
 |-- logs/  contains the full build log for each target architecture
 |-- libs/  contains the compiled libraries for each target architecture
```
If something goes wrong during the compilation of a particular target architecture, the main script will be terminated and you can see the full log in `./openssl-build-output/logs/<arch>.log`. So for example if there's an error for <b>x86</b>, you can see the full log in `./openssl-build-output/logs/x86.log`

## License

    Copyright (C) 2015-2016 Aleksandar Gotev

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
