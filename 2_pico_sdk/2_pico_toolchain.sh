#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export SUPPORTED_BOARDS="$PWD/supported_boards.txt"
echo "Creating fresh $PICO_SDK_REPOS"
rm -fr $PICO_SDK_REPOS
mkdir --parents $PICO_SDK_REPOS

pushd $PICO_SDK_REPOS

  echo ""
  echo "Cloning Raspberry Pi Pico SDK repositories"
  git config --global advice.detachedHead false
  git clone --quiet $PICO_SDK_URL
  git clone --quiet $PICO_EXAMPLES_URL
  git clone --quiet $PICO_EXTRAS_URL
  git clone --quiet $PICO_PLAYGROUND_URL
  git clone --quiet $FREERTOS_KERNEL_URL

  echo ""
  echo "Listing supported boards to $SUPPORTED_BOARDS"
  ls -1 $PICO_SDK_REPOS/pico-sdk/src/boards/include/boards > $SUPPORTED_BOARDS

  echo ""
  echo "Cloning Pico utilities"
  git clone --quiet $PICOTOOL_URL
  git clone --quiet $OPENOCD_URL

  pushd $PICOTOOL_PATH
    echo ""
    echo "Building picotool"
    mkdir build
    cd build
    cmake ../ \
      > $PICO_SDK_REPOS/picotool.log 2>&1
    /usr/bin/time make -j`nproc` \
      >> $PICO_SDK_REPOS/picotool.log 2>&1
    echo ""
    echo ""
    echo "Installing picotool as 'root'!!"
    sudo make install \
      >> $PICO_SDK_REPOS/picotool.log 2>&1
    picotool version
  popd

  pushd $OPENOCD_PATH
    echo ""
    echo "Building openocd"
    ./bootstrap \
      > $PICO_SDK_REPOS/openocd.log 2>&1
    ./configure \
      --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio --disable-werror \
      >> $PICO_SDK_REPOS/openocd.log 2>&1
    /usr/bin/time make -j`nproc` \
      >> $PICO_SDK_REPOS/openocd.log 2>&1
    echo ""
    echo ""
    echo "Installing openocd as 'root'!!"
    sudo make install \
      >> $PICO_SDK_REPOS/openocd.log 2>&1
    openocd --version
  popd

  echo ""
  echo "Downloading Debug Probe firmware"
  curl -sOL $DEBUG_PROBE_FIRMWARE

popd

echo "Finished"
