#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/pico_utilities.log"
rm --force $LOGFILE

mkdir --parents $OPENOCD_PATH
echo ""
pushd $OPENOCD_PATH/..
  echo "Cloning openocd"
  rm --force --recursive $OPENOCD_PATH
  git clone --quiet $OPENOCD_URL
  cd $OPENOCD_PATH
  echo "Building openocd"
  ./bootstrap \
    >> $LOGFILE 2>&1
  ./configure \
    --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio --disable-werror \
    >> $LOGFILE 2>&1
  /usr/bin/time make -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Installing openocd as 'root'!!"
  sudo make install \
    >> $LOGFILE 2>&1
  openocd --version
popd > /dev/null

mkdir --parents $PICOTOOL_PATH
echo ""
pushd $PICOTOOL_PATH/..
  echo "Cloning picotool"
  rm --force --recursive $PICOTOOL_PATH
  git clone --quiet $PICOTOOL_URL
  cd $PICOTOOL_PATH
  echo "Building picotool"
  mkdir build
  cd build
  cmake ../ \
    >> $LOGFILE 2>&1
  /usr/bin/time make -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Installing picotool as 'root'!!"
  sudo make install \
    >> $LOGFILE 2>&1
  picotool version
popd > /dev/null

echo ""
pushd $PICO_SDK_REPOS
  echo "Downloading Debug Probe firmware"
  curl -sOL $DEBUG_PROBE_FIRMWARE
popd > /dev/null

echo "Finished"
