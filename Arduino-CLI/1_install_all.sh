#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_basic_devel.sh
./arduino_cli.sh
./arduino_pico.sh
./teensyduino.sh
./daisyduino.sh
./esp32.sh
./list_boards_and_examples.sh
