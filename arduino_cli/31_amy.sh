#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/31_amy.log
rm --force $LOGFILE

echo "Enabling GitHub library installs"
arduino-cli config set library.enable_unsafe_install true
arduino-cli config dump

# installing AMY library
arduino-cli lib install --git-url $AMY_URL \
  >> $LOGFILE 2>&1

echo "Disabling GitHub library installs"
arduino-cli config set library.enable_unsafe_install false
arduino-cli config dump

echo "Finished"
