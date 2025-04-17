#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/2_global_linux_dependencies.log
rm --force $LOGFILE

echo "Installing base packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  7zip \
  android-sdk-platform-tools \
  apt-file \
  autoconf \
  automake \
  bison \
  build-essential \
  calibre \
  ccache \
  clang \
  cmake \
  device-tree-compiler \
  dfu-util \
  fastboot \
  file \
  flex \
  g++ \
  g++-multilib \
  gcc \
  gcc-multilib \
  gdb-multiarch \
  gperf \
  gtkwave \
  kmod \
  libcanberra-gtk3-module \
  libftdi-dev \
  libgtk-3-0 \
  libmagic1 \
  libnss3 \
  libpam-systemd \
  libsdl2-dev \
  libsecret-1-0 \
  libtool \
  libusb-1.0-0-dev \
  libxkbfile1 \
  lsb-release \
  lynx \
  make \
  man-db \
  minicom \
  ninja-build \
  pandoc \
  picocom \
  pkg-config \
  plocate \
  python3-dev \
  python3-myst-parser \
  python3-pip \
  python3-serial \
  python3-setuptools \
  python3-sphinx \
  python3-sphinx-rtd-theme \
  python3-sphinxcontrib-mermaid \
  python3-tk \
  python3-venv \
  python3-wheel \
  screen \
  speedtest-cli \
  systemd \
  texinfo \
  tmux \
  tree \
  usbutils \
  wget \
  xz-utils \
  >> $LOGFILE 2>&1

echo "Finished"
