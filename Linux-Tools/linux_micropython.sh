#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_micropython.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  libffi-dev

mkdir --parents $MICROPYTHON_PATH
pushd $MICROPYTHON_PATH/..
  echo "Cloning MicroPython"
  rm -fr $MICROPYTHON_PATH
  /usr/bin/time git clone $MICROPYTHON_URL \
    >> $LOGFILE 2>&1
popd

pushd $MICROPYTHON_PATH
  echo "Building mpy-cross"
  make -C mpy-cross \
    >> $LOGFILE 2>&1
popd

pushd $MICROPYTHON_PATH/ports/unix
  echo "Fetching submodules"
  /usr/bin/time make submodules -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Building Unix port"
  /usr/bin/time make -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Copying micropython to $HOME/.local/bin"
  cp build-standard/micropython $HOME/.local/bin
  popd

echo "Finished"
