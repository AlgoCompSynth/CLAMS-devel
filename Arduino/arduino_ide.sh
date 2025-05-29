#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/arduino_ide.log
rm --force $LOGFILE

echo "Downloading Arduino IDE zipfile"
pushd /tmp
  curl -sOL $ARDUINO_IDE_URL
popd

echo "Installing"
pushd $HOME/.local
  rm --force --recursive arduino-ide*
  unzip /tmp/$ARDUINO_IDE_ZIPFILE \
    >> $LOGFILE 2>&1
  ln -sf $ARDUINO_IDE_PATH/arduino-ide $HOME/.local/bin/
popd

echo "Finished"
