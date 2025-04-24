#! /usr/bin/env bash

set -e

echo "Removing any previous installation"
rm --force --recursive $HOME/.local/bin/arduino-cli
rm --force --recursive $HOME/.arduino15
rm --force --recursive $HOME/Arduino
echo "Finished"
