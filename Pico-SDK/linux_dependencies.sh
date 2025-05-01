#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

echo "Installing Linux build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  automake \
  libtool \
  libusb-1.0-0-dev \
  >> $LOGFILE 2>&1

echo "Finished"
