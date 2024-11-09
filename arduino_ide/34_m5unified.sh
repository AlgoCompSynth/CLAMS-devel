#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/34_m5unified.log
rm --force $LOGFILE

echo "Installing M5Unified library"
arduino-cli lib install "M5Unified" \
  >> $LOGFILE 2>&1

echo "Finished"
