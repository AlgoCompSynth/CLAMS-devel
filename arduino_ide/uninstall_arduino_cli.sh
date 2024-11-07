#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Removing any previous installation"
rm --force --recursive $ARDUINO_INSTALL_PATH
rm --force --recursive $ARDUINO_IDE_PATH

echo "Finished"
