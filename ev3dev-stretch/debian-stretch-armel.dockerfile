FROM ev3dev/debian-stretch-armel-qemu-minbase

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
    wget https://github.com/ev3dev/ev3dev-crosstool-ng/releases/download/gcc-ev3dev-6.3.0-2017.10/gcc-ev3dev-6.3.0-2017.10-x86_64_arm-ev3-linux-gnueabi.tar.gz && \
    tar xf gcc-ev3dev-6.3.0-2017.10-x86_64_arm-ev3-linux-gnueabi.tar.gz && \
    rm gcc-ev3dev-6.3.0-2017.10-x86_64_arm-ev3-linux-gnueabi.tar.gz && \
    ln -s gcc-ev3dev-6.3.0-2017.10-x86_64_arm-ev3-linux-gnueabi arm-ev3-linux-gnueabi

# setup a new user
COPY compiler.sudoers /etc/sudoers.d/compiler
RUN chmod 0440 /etc/sudoers.d/compiler && \
    adduser --disabled-password --gecos \"\" compiler && \
    usermod -a -G sudo compiler
USER compiler
COPY toolchain.cmake.armel /home/compiler/toolchain.cmake
WORKDIR /home/compiler
CMD ["/bin/bash"] ["--login"]
