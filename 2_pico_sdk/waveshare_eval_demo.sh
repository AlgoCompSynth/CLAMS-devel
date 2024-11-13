#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/waveshare_eval_demo.log
rm --force $LOGFILE

echo "Downloading Waveshare Evaluation Board demo"
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  rm --force --recursive Pico-Eval-Board-Code*
  curl -sOL https://files.waveshare.com/upload/5/5a/Pico-Eval-Board-Code.zip
  unzip Pico-Eval-Board-Code.zip
popd

echo "Building"
pushd $HOME/Projects/Pico-Eval-Board-Code/c/07_PIO/PIO-I2S
  cp $PICO_SDK_PATH/external/pico_sdk_import.cmake .

  for board in pico pico2
  do
    echo ""
    echo "..building $board"
    export PICO_BOARD=$board
    rm --force --recursive build_$PICO_BOARD
    mkdir --parents build_$PICO_BOARD
    cd build_$PICO_BOARD
    cmake .. > cmake.log 2>&1
    make > make.log 2>&1
    cd ..
  done
popd

echo "Finished"