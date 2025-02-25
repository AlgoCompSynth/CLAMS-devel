#! /usr/bin/env bash

set -e

./10_arduino_cli.sh
./20_arduino_pico.sh
./21_esp32.sh
./22_teensyduino.sh
./23_daisyduino.sh
./amy.sh
./mozzi.sh
./list_boards_and_examples.sh
