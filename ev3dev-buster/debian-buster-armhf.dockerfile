FROM ev3dev/debian-buster-armhf-qemu-minbase

# setup repositories and install required packages
COPY apt.sources.list.debian /etc/apt/sources.list
COPY ev3dev-archive-keyring.gpg /etc/apt/trusted.gpg.d/
RUN dpkg --add-architecture amd64 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes xz-utils \
        libc6:amd64 libz1:amd64 liblzma5:amd64 libncurses5:amd64 libpython2.7:amd64 \
        build-essential cmake valac man-db bash-completion sudo vim nano less tree wget

# install the cross-compiler toolchain
RUN cd /opt && \
    wget http://releases.linaro.org/components/toolchain/binaries/6.3-2017.02/arm-linux-gnueabihf/gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf.tar.xz && \
    tar xf gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf.tar.xz && \
    rm gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf.tar.xz

# setup a new user
COPY compiler.sudoers /etc/sudoers.d/compiler
RUN chmod 0440 /etc/sudoers.d/compiler && \
    adduser --disabled-password --gecos \"\" compiler && \
    usermod -a -G sudo compiler
USER compiler
COPY toolchain.cmake.armhf /home/compiler/toolchain.cmake
WORKDIR /home/compiler
CMD ["/bin/bash"] ["--login"]
