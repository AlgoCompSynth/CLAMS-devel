#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/32_adafruit.log
rm --force $LOGFILE

echo "Installing Adafruit libraries"
arduino-cli lib install "Adafruit TinyUSB Library" \
  >> $LOGFILE 2>&1
arduino-cli lib install "Audio - Adafruit Fork" \
  >> $LOGFILE 2>&1

# https://github.com/pschatzmann/Adafruit_TinyUSB_Arduino/discussions/1
echo "Installing Adafruit_TinyUSB_Arduino from GitHub"
pushd $ADAFRUIT_TINYUSB_ARDUINO_PATH/..
  rm --force --recursive $ADAFRUIT_TINYUSB_ARDUINO_PATH
  /usr/bin/time git clone $ADAFRUIT_TINYUSB_ARDUINO_URL \
    >> $LOGFILE 2>&1
popd

echo "Finished"
