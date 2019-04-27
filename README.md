docker-cross
============

This repository hosts the dockerfiles for building the ev3dev cross-compiler
images.

You can get the images by running one of the following:

    docker pull ev3dev/debian-jessie-cross
    docker pull ev3dev/debian-jessie-armel-cross
    docker pull ev3dev/debian-jessie-armhf-cross
    docker pull ev3dev/debian-stretch-cross
    docker pull ev3dev/debian-stretch-armel-cross
    docker pull ev3dev/debian-stretch-armhf-cross
    docker pull ev3dev/debian-buster-cross
    docker pull ev3dev/debian-buster-armel-cross
    docker pull ev3dev/debian-buster-armhf-cross

The `debian-<dist>-cross` images have an amd64 root file system and cross
compilers for armel and armhf. These images can be used to compile anything
that has proper multiarch support.

The `debian-<dist>-<arch>-cross` images contain an foreign arch root file system
and an amd64 cross compiler that targets the rootfs arch. These images are used
for cases where multiarch support does not work, but will be slower because
many things are running via QEMU.
