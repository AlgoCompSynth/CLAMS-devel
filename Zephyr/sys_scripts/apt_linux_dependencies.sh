#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/linux_dependencies.log"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --assume-yes --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  ccache \
  cmake \
  curl \
  device-tree-compiler \
  dfu-util \
  file \
  gcc \
  gcc-multilib \
  git \
  g++-multilib \
  gperf \
  gpg-agent \
  libmagic1 \
  libsdl2-dev \
  lsb-release \
  lynx \
  make \
  man-db \
  minicom \
  ninja-build \
  pkg-config \
  plocate \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-tk \
  python3-venv \
  python3-wheel \
  screen \
  speedtest-cli \
  time \
  tmux \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  xz-utils \
  >> $LOGFILE 2>&1

echo "*** Linux Dependencies Finished ***"
