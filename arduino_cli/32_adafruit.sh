#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/32_adafruit.sh.log
rm --force $LOGFILE

echo "Installing Adafruit libraries"
arduino-cli lib install "Adafruit SPIFlash" \
  >> $LOGFILE 2>&1
arduino-cli lib install "Adafruit TinyFlash" \
  >> $LOGFILE 2>&1
arduino-cli lib install "Adafruit TinyUSB Library" \
  >> $LOGFILE 2>&1
arduino-cli lib install "Adafruit WavePlayer Library" \
  >> $LOGFILE 2>&1
arduino-cli lib install "Audio - Adafruit Fork" \
  >> $LOGFILE 2>&1
arduino-cli lib install "PicoDVI - Adafruit Fork" \
  >> $LOGFILE 2>&1
arduino-cli lib install "usb_midi_host" \
  >> $LOGFILE 2>&1

echo "Finished"
