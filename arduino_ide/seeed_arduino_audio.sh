#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/seeed_arduino_audio.log
rm --force $LOGFILE

echo "Enabling GitHub library installs"
arduino-cli config set library.enable_unsafe_install true

echo "Installing Arduino Audio tools"
arduino-cli lib install --git-url $ARDUINO_AUDIO_TOOLS_URL \
  >> $LOGFILE 2>&1

echo "Disabling GitHub library installs"
arduino-cli config set library.enable_unsafe_install false

echo "Finished"
