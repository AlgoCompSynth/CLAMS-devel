#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/20_arduino_pico.log
rm --force $LOGFILE

# https://arduino-pico.readthedocs.io/en/latest/install.html#installing-via-arduino-cli
echo "Installing Arduino Pico from package release"
arduino-cli config add board_manager.additional_urls $ARDUINO_PICO_PACKAGE_URL \
  >> $LOGFILE 2>&1
arduino-cli core update-index \
  >> $LOGFILE 2>&1
arduino-cli core install rp2040:rp2040 \
  >> $LOGFILE 2>&1

echo "Finished"
