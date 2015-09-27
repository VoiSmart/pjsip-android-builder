# pjsip-android-builder
Easily build PJSIP for Android, by using a Linux virtual machine

# Purpose
I needed a fast and easily replicable build system to build PJSIP http://www.pjsip.org/ library for Android, without having to deal with compilation issues every time and waste a lot of time reading docs and forums. So, I thought of making a Linux virtual machine and make some scripts to easily download all the requirements and configure it to be a complete build environment, without affecting my computer which has already plenty of developer stuff on it :D
If you want to contribute, your help is really appreciated :)

# Setup
First, you need a virtualization system. There are plenty of choices out there. Choose the one that you prefer (VirtualBox, vmWare, Vagrant, you name it). I'm supposing that you know what a virtual machine is and how to setup your environment to be able to run virtual machines. So, let's begin :)

1. Download the latest Ubuntu Server ISO: http://www.ubuntu.com/download/server <br>I've chosen this distro because it has a good support for the applications that we need and it's kept updated. In the future, support to other distributions can be added as well, with your help :)
2. Create a new virtual machine with at least 1GB RAM and 20GB virtual hard drive. Add as many RAM and processors as you can, so the compilation process will be faster.
3. Install Ubuntu Server
4. SSH into your newly installed VM and execute the following commands, which will install all the required packages and files to be able to build PJSIP<br>
```
sudo su
apt-get update && apt-get -y upgrade && apt-get install -y git
git clone https://github.com/alexbbb/pjsip-android-builder
cd pjsip-android-builder
./prepare-build-system
```

# Build PJSIP
After you have successfully set up you VM, to build PJSIP, go into pjsip-android-builder and execute:
```
./build
```
The script is going to create a new folder named <b>pjsip-build</b> organized as follows:
```
pjsip-build
 |-- logs\  contains the full build log for each target architecture
 |-- lib\   contains the compiled libraries for each architecture
 |-- src\   contains PJSUA Java wrapper to work with the library
```
