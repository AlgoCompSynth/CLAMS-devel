#! /bin/bash

set -e

export DEVICE="/dev/tty${1-ACM0}"
echo "DEVICE: $DEVICE"
ls -l $DEVICE
export BAUDRATE=1200
echo "BAUDRATE: $BAUDRATE"

echo "Starting minicom"
sleep 5
minicom --baudrate $BAUDRATE --noinit --device $DEVICE
