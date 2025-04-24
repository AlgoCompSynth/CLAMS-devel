#! /usr/bin/env bash

set -e

./arduino_cli.sh
./arduino_pico.sh
./teensyduino.sh
./daisyduino.sh
./list_boards_and_examples.sh
