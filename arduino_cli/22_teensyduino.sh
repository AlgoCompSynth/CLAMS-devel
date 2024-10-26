#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/22_teensyduino.log
rm --force $LOGFILE

# https://www.pjrc.com/teensy/td_download.html
echo "Installing teensy:avr core"
arduino-cli config add board_manager.additional_urls $TEENSYDUINO_PACKAGE_URL \
  >> $LOGFILE 2>&1
arduino-cli core update-index \
  >> $LOGFILE 2>&1
arduino-cli core install teensy:avr \
  >> $LOGFILE 2>&1

echo "Cloning fresh teensy_loader_cli project repository"
mkdir --parents $TEENSY_LOADER_CLI_PATH
pushd $TEENSY_LOADER_CLI_PATH/..
  rm --force --recursive $TEENSY_LOADER_CLI_PATH
  /usr/bin/time git clone $TEENSY_LOADER_CLI_URL \
    >> $LOGFILE 2>&1
popd

echo "Installing teensy_loader_cli"
pushd $TEENSY_LOADER_CLI_PATH
  make \
    >> $LOGFILE 2>&1
  cp teensy_loader_cli $HOME/.local/bin
popd

echo "Finished"
