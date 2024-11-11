#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/35_mozzi.log
rm --force $LOGFILE

echo "Installing Mozzi library"
arduino-cli lib install "Mozzi" \
  >> $LOGFILE 2>&1

echo "Finished"
