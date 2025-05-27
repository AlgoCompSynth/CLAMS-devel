#! /usr/bin/env bash

set -e

./apt_audio_base.sh
./linux_dependencies.sh
./apt_pkg_db_updates.sh
./arduino_ide.sh
./arduino_cli.sh
./arduino_pico.sh
./amy.sh
./teensyduino.sh
./arduino_audio_tools.sh
./list_boards_and_examples.sh
