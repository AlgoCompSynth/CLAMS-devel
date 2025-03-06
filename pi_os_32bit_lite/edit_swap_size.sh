#! /usr/bin/env bash

set -e

# https://pimylifeup.com/raspberry-pi-swap-file/
sudo dphys-swapfile swapoff
sudo nano /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

echo "Finished"
