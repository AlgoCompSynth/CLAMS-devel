#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/pico_ice_micropython.log
rm --force $LOGFILE

mkdir --parents $PICO_ICE_MICROPYTHON_PATH
pushd $PICO_ICE_MICROPYTHON_PATH/..
  echo "Cloning MicroPython"
  rm -fr $PICO_ICE_MICROPYTHON_PATH
  /usr/bin/time git clone $PICO_ICE_MICROPYTHON_URL \
    >> $LOGFILE 2>&1
popd

pushd $PICO_ICE_MICROPYTHON_PATH

  echo "Fetching submodules"
  /usr/bin/time git submodule update --init lib/micropython \
    >> $LOGFILE 2>&1
  /usr/bin/time git submodule update --init lib/pico-ice-mpy-module \
    >> $LOGFILE 2>&1
  cd lib/pico-ice-mpy-module
  /usr/bin/time git submodule update --init pico-ice-sdk \
    >> $LOGFILE 2>&1
  cd ../..

  echo "Building mpy-cross"
  /usr/bin/time make -C lib/micropython/mpy-cross --jobs=`nproc` \
    >> $LOGFILE 2>&1

  echo "Building submodules"
  /usr/bin/time make -C lib/micropython/ports/rp2 submodules \
    >> $LOGFILE 2>&1

  cd boards/PICO_ICE

  echo "Building MicroPython pico2_ice_arm"
  mkdir pico2_ice_arm && cd pico2_ice_arm
  cmake -DPICO_BOARD=pico2_ice .. \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
  picotool info firmware.uf2 \
    >> $LOGFILE 2>&1
  cd ..

  echo "Building MicroPython pico2_ice_riscv"
  mkdir pico2_ice_riscv && cd pico2_ice_riscv
  cmake -DPICO_BOARD=pico2_ice -DPICO_PLATFORM=rp2350-riscv .. \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
  picotool info firmware.uf2 \
    >> $LOGFILE 2>&1
  cd ..

  echo "Building MicroPython pico_ice"
  mkdir pico_ice && cd pico_ice
  cmake -DPICO_BOARD=pico_ice .. \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
  picotool info firmware.uf2 \
    >> $LOGFILE 2>&1
  cd ..

popd

echo "Finished"
