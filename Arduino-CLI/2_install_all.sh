#! /usr/bin/env bash

set -e

./apt_audio_base.sh
./arduino_cli.sh
./arduino_pico.sh
./amy.sh
./teensyduino.sh
./daisyduino.sh
./esp32.sh
./list_boards_and_examples.sh
./apt_pkg_db_updates.sh
