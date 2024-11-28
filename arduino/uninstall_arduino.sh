#! /usr/bin/env bash

set -e

echo "Removing any previous installation"
rm --force --recursive $HOME/.local/bin/arduino-*
rm --force --recursive $HOME/.local/arduino-ide*
rm --force --recursive $HOME/.config/arduino-ide
rm --force --recursive "$HOME/.config/Arduino IDE"
rm --force --recursive $HOME/.arduino15
rm --force --recursive $HOME/.arduinoIDE
rm --force --recursive $HOME/Arduino
echo "Finished"