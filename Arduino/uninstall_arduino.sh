#! /usr/bin/env bash

set -e

echo "Removing any previous installation"
rm --force $HOME/.local/bin/arduino-cli
rm --force $HOME/.local/bin/arduino-ide
rm --force --recursive $HOME/.local/arduino-ide*
rm --force --recursive $HOME/.arduino15
rm --force --recursive $HOME/Arduino
echo "Finished"
