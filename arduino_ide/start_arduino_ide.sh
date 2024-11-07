#! /usr/bin/env bash

set -e

source $HOME/set_pico_envars
pushd $ARDUINO_IDE_PATH
$ARDUINO_IDE_EXECUTABLE > /dev/null 2>&1 &
