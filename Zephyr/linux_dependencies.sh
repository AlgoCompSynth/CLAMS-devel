#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

echo "Installing Linux build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  ccache \
  cmake \
  device-tree-compiler \
  dfu-util \
  file \
  gcc \
  gcc-multilib \
  git \
  g++-multilib \
  gperf \
  libmagic1 \
  libsdl2-dev \
  make \
  ninja-build \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-tk \
  python3-wheel \
  wget \
  xz-utils \
  >> $LOGFILE 2>&1

echo "Finished"
