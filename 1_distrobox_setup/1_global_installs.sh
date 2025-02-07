#! /usr/bin/env bash

set -e

if [ ! "$WSL_DISTRO_NAME" = "Ubuntu-24.04" ]
then
  # not on WSL - we need to unminimize
  echo "Running in a Distrobox container - restoring missing documentation"
  ./unminimize.sh
  echo ""
fi

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/1_global_installs.log
rm --force $LOGFILE

echo "Adding git PPA"
/usr/bin/time ./add_git_ppa.sh \
  >> $LOGFILE 2>&1

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
  dfu-util \
  device-tree-compiler \
  fastboot \
  file \
  flex \
  g++ \
  gcc \
  g++-multilib \
  gcc-multilib \
  gdb-multiarch \
  git-lfs \
  gperf \
  gtkwave \
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
  picocom \
  pkg-config \
  plocate \
  python3-dev \
  python3-myst-parser \
  python3-pip \
  python3-serial \
  python3-setuptools \
  python3-sphinx \
  python3-sphinxcontrib-mermaid \
  python3-sphinx-rtd-theme \
  pandoc \
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
  xz-utils \
  wget \
  >> $LOGFILE 2>&1

echo "Finished"
