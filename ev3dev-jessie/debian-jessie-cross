FROM debian:jessie

# setup repositories and install required packages
COPY apt.sources.list.debian /etc/apt/sources.list
RUN dpkg --add-architecture armel && \
    dpkg --add-architecture armhf && \
    apt-key adv --keyserver pgp.mit.edu --recv-keys D57D95AF93178A7C && \
    apt-key adv --keyserver pgp.mit.edu --recv-keys 7DE089671804772E && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        bash-completion \
        ca-certificates \
        cmake \
        crossbuild-essential-armel \
        crossbuild-essential-armhf \
        gdb \
        less \
        man-db \
        nano \
        pkg-config \
        qemu-user-static \
        sudo \
        tree \
        valac \
        vim \
        wget \
        xz-utils

# setup a new user
COPY compiler.sudoers /etc/sudoers.d/compiler
RUN chmod 0440 /etc/sudoers.d/compiler && \
    adduser --disabled-password --gecos \"\" compiler && \
    usermod -a -G sudo compiler
USER compiler
WORKDIR /home/compiler
CMD ["/bin/bash"] ["--login"]

ADD ["toolchain-*.cmake", "/home/compiler/"]
