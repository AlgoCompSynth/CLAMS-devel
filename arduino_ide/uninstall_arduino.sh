#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Removing any previous installation"
rm --force --recursive $ARDUINO_UNINSTALL_PATH

echo "Finished"
