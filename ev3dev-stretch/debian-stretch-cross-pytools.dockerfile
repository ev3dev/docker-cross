FROM ev3dev:debian-stretch-cross

# Install python tools needed for cross builds
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        python \
        scons
