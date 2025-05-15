#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/apt_basic_devel.log"
rm --force $LOGFILE

echo "Installing basic development packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  chrpath \
  cmake \
  curl \
  diffstat \
  file \
  gawk \
  gcc-multilib \
  lsb-release \
  lynx \
  lz4 \
  man-db \
  minicom \
  ninja-build \
  pkg-config \
  plocate \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  screen \
  speedtest-cli \
  texinfo \
  tmux \
  tree \
  unzip \
  usbutils \
  wget \
  zstd \
  >> $LOGFILE 2>&1

echo "Finished"
