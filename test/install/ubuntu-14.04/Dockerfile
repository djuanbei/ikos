FROM ubuntu:14.04
MAINTAINER Maxime Arthaud <maxime.arthaud@nasa.gov>
ARG njobs=2
ARG build_type=Release

# Installs the following versions (note that it might be out of date):
# cmake 2.8.12.2
# gmp 5.1.3
# boost 1.55.0
# python 2.7.6
# sqlite 3.8.2
# llvm 4.0.1
# clang 4.0.1
# gcc 8.2.0

# Upgrade
RUN apt-get update
RUN apt-get upgrade -y

# Install add-apt-repository
RUN apt-get install -y software-properties-common

# Add ppa for gcc-8 and g++-8
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test

# Add ppa for llvm 4.0
RUN add-apt-repository -y "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-4.0 main"

# Refresh cache
RUN apt-get update

# Install all dependencies
RUN apt-get install -y cmake libgmp-dev libsqlite3-dev libz-dev libedit-dev \
        libboost1.55-dev libboost-filesystem1.55-dev libboost-test1.55-dev \
        gcc-8 g++-8
RUN apt-get install -y --force-yes llvm-4.0 clang-4.0

# Update path to include llvm
ENV PATH "/usr/lib/llvm-4.0/bin:$PATH"

# Add ikos source code
ADD . /root/ikos

# Build ikos
RUN rm -rf /root/ikos/build && mkdir /root/ikos/build
WORKDIR /root/ikos/build
ENV MAKEFLAGS "-j$njobs"
RUN CC=gcc-8 CXX=g++-8 cmake \
        -DCMAKE_INSTALL_PREFIX="/opt/ikos" \
        -DCMAKE_BUILD_TYPE="$build_type" \
        ..
RUN make
RUN make install

# Run the tests
RUN make check

# Add ikos to the path
ENV PATH "/opt/ikos/bin:$PATH"

# Done
WORKDIR /