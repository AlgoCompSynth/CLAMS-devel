#! /usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/1_global_installs.log
rm --force $LOGFILE

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Setting locale"
sudo cp locale.gen /etc/
sudo locale-gen

echo "Installing Linux packages"
sudo apt-get update
sudo apt-get upgrade -qqy
sudo apt-get autoremove -qqy
time sudo apt-get install -y \
  alsa-utils \
  apt-file \
  bash-completion \
  bison \
  build-essential \
  curl \
  file \
  flex \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  freepats \
  gdb \
  libasound2-dev \
  libasound2-doc \
  libasound2-plugins \
  libfftw3-bin \
  libfftw3-dev \
  libsndfile1-dev \
  libsox-dev \
  libsox-fmt-all \
  libsoxr-dev \
  lsb-release \
  lynx \
  man-db \
  minicom \
  net-tools \
  opus-tools \
  plocate \
  pmidi \
  screen \
  sox \
  speedtest-cli \
  sysstat \
  time \
  timidity \
  timidity-daemon \
  tmux \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

# https://wiki.debian.org/sysstat
echo "Select 'Yes' to start sysstat data collection"
sudo dpkg-reconfigure sysstat

echo "Enabling sysstat"
sudo systemctl enable --now sysstat.service
systemctl status sysstat.service

echo "Stopping data collections"
sudo systemctl stop sysstat

echo "Editing sample time"
sleep 5
diff sysstat-collect.timer /etc/systemd/system/sysstat.service.wants/sysstat-collect.timer || true
sudo cp sysstat-collect.timer /etc/systemd/system/sysstat.service.wants/sysstat-collect.timer

echo "Restarting data collection"
sudo systemctl daemon-reload
sudo systemctl restart sysstat

echo "Disk space"
df -h
lsb_release --all || true

echo "Finished!"
