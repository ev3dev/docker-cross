FROM ev3dev/debian-jessie-armhf-qemu-minbase

# setup repositories and install required packages
COPY apt.sources.list.debian /etc/apt/sources.list
RUN dpkg --add-architecture amd64 && \
    apt-key adv --keyserver pgp.mit.edu --recv-keys 2B210565 && \
    apt-get update && \
    apt-get install --yes xz-utils libc6:amd64 libz1:amd64 \
        build-essential cmake valac man-db bash-completion sudo vim nano less

# install the cross-compiler toolchain
ADD https://releases.linaro.org/components/toolchain/binaries/5.3-2016.02/arm-linux-gnueabihf/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz /opt/
RUN cd /opt && \
    tar xf gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz && \
    rm gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz
COPY toolchain.cmake.armhf /opt/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf/toolchain.cmake

# setup a new user
COPY compiler.sudoers /etc/sudoers.d/compiler
RUN chmod 0440 /etc/sudoers.d/compiler && \
    adduser --disabled-password --gecos \"\" compiler && \
    usermod -a -G sudo compiler
USER compiler
WORKDIR /home/compiler
CMD ["/bin/bash"] ["--login"]
