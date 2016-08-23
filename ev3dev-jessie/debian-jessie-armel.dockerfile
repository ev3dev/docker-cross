FROM ev3dev/debian-jessie-armel-qemu-minbase

# setup repositories and install required packages
COPY apt.sources.list.debian /etc/apt/sources.list
RUN dpkg --add-architecture i386 && \
    apt-key adv --keyserver pgp.mit.edu --recv-keys 2B210565 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes xz-utils \
        libc6:i386 libstdc++6:i386 libz1:i386 libncurses5:i386 libpython2.7:i386 \
        build-essential cmake valac man-db bash-completion sudo vim nano less tree wget

# install the cross-compiler toolchain
ADD http://releases.linaro.org/14.04/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux.tar.xz /opt/
RUN cd /opt && \
    tar xf gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux.tar.xz && \
    rm gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux.tar.xz
COPY toolchain.cmake.armel /opt/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/toolchain.cmake

# setup a new user
COPY compiler.sudoers /etc/sudoers.d/compiler
RUN chmod 0440 /etc/sudoers.d/compiler && \
    adduser --disabled-password --gecos \"\" compiler && \
    usermod -a -G sudo compiler
USER compiler
WORKDIR /home/compiler
CMD ["/bin/bash"] ["--login"]
