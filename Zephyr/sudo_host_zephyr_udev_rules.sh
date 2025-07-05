#! /usr/bin/env bash

set -e

echo ""
echo "** Udev Rules **"

source set_container_envars.sh
echo ""
echo "ZEPHYR_OPENOCD_SRC: $ZEPHYR_OPENOCD_SRC"
echo "HOST_OPENOCD_DEST: $HOST_OPENOCD_DEST"

sed "s/MODE=\"660\"/MODE=\"666\"/" $ZEPHYR_OPENOCD_SRC \
  | sed "s/MODE=\"0660\"/MODE=\"0666\"/" \
  > temp
sudo mv temp $HOST_OPENOCD_DEST
sudo udevadm control --reload

echo ""
echo "** Udev Rules Finished **"
