#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/amy.log
rm --force $LOGFILE

echo "Installing AMY Synthesizer"
arduino-cli lib install "AMY Synthesizer" \
  >> $LOGFILE 2>&1

echo "Installing MIDI Library"
arduino-cli lib install "MIDI Library" \
  >> $LOGFILE 2>&1

echo "Finished"
