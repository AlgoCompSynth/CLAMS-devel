#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

echo "Installing Linux build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  libcanberra-gtk3-module \
  libnss3 \
  libsecret-1-0 \
  libxkbfile1 \
  >> $LOGFILE 2>&1

echo "Finished"
