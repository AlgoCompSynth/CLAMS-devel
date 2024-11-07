#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/23_daisyduino.log
rm --force $LOGFILE

# https://github.com/stm32duino/Arduino_Core_STM32/wiki/Getting-Started
echo "Installing STMicroelectronics:stm32 core"
arduino-cli config add board_manager.additional_urls $DAISYDUINO_PACKAGE_URL \
  >> $LOGFILE 2>&1
arduino-cli core update-index \
  >> $LOGFILE 2>&1
arduino-cli core install STMicroelectronics:stm32 \
  >> $LOGFILE 2>&1

echo "Installing DaisyDuino library"
arduino-cli lib install DaisyDuino \
  >> $LOGFILE 2>&1

echo "Installing U8g2 OLED library"
arduino-cli lib install U8g2 \
  >> $LOGFILE 2>&1

echo ""
echo ""
echo "You need to install STMCubeProgrammer manually! See"
echo ""
echo "    https://github.com/stm32duino/Arduino_Core_STM32/wiki/Upload-methods#stm32cubeprogrammer"
echo ""
echo "for directions."
echo ""
echo "Finished"
