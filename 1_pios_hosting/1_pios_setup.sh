#! /usr/bin/env bash

set -e

echo ""
echo "* Pi OS Setup *"

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/1_pios_setup.log
rm --force $LOGFILE

echo "Creating \$HOME/.local/bin"
mkdir --parents $HOME/.local/bin

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing base packages"
sudo apt-get install -qqy \
  apt-file \
  bash-completion \
  build-essential \
  byobu \
  cmake \
  curl \
  file \
  git \
  lsb-release \
  lynx \
  man-db \
  minicom \
  pipewire-doc \
  pkg-config \
  plocate \
  podman \
  qpwgraph \
  screen \
  speedtest-cli \
  tilix \
  time \
  tmux \
  tree \
  uidmap \
  unzip \
  usbutils \
  variety \
  vim \
  wget \
  wireplumber-doc \
  >> $LOGFILE 2>&1

./nerd_fonts.sh
./starship.sh
./rust.sh
./distrobox.sh

echo "* Finished Terminal Setup *"
