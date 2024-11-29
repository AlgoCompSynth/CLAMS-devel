#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/adafruit.log
rm --force $LOGFILE

echo "Installing Adafruit libraries"
arduino-cli lib install "Audio - Adafruit Fork" \
  >> $LOGFILE 2>&1

echo "Finished"
