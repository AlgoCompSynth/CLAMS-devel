#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/m5unified.log
rm --force $LOGFILE

echo "Installing M5Unified library"
arduino-cli lib install "M5Unified" \
  >> $LOGFILE 2>&1

echo "Finished"
