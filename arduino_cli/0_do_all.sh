#! /usr/bin/env bash

set -e

rm --force *.log

./uninstall_arduino_cli.sh
for script in \
  10_arduino_cli.sh \
  20_arduino_pico.sh \
  21_esp32.sh \
  22_teensyduino.sh \
  23_daisyduino.sh \
  30_arduino_audio_tools.sh \
  31_amy.sh \
  90_adafruit_tinyusb_arduino_pico.sh
do
  ./$script
done
./list_boards_and_examples.sh
