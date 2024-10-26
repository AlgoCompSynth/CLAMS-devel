#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Installing PlatformIO rules"
curl -fsSL $PLATFORMIO_UDEV_RULES_URL | sudo tee $PLATFORMIO_UDEV_RULES_PATH

echo "Installing picotool udev rules as 'root'!!"
sudo cp 99-picotool.rules $SYSTEM_UDEV_PATH/

echo "Installing Arduino MBED RP2040 udev rules as 'root'!!"
sudo cp 60-arduino-mbed.rules $SYSTEM_UDEV_PATH/

echo "Installing Zephyr OS openocd udev rules as 'root'!!"
sudo cp 60-openocd.rules $SYSTEM_UDEV_PATH/

echo "Installing apio FPGA udev rules as 'root'!!"
sudo cp 80-fpga-*.rules $SYSTEM_UDEV_PATH/

echo "Installing teensy udev rules as 'root'!!"
sudo cp 00-teensy.rules $SYSTEM_UDEV_PATH/

echo "Installing TinyUSB udev rules as 'root'!!"
sudo cp 99-tinyusb.rules $SYSTEM_UDEV_PATH/

echo "Reloading"
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Finished"
