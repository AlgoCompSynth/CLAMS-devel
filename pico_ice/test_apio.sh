#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Activating virtual environment $APIO_VENV"
source $ACTIVATE_APIO_VENV

# https://pico-ice.tinyvision.ai/md_programming_the_fpga.html

# Build a new directory with a "blinky" example project inside
rm -fr pico-ice-blinky
mkdir pico-ice-blinky
cd pico-ice-blinky
apio examples -f iCE40-UP5K/blink

# Set the board to "pico-ice"
apio init --top-module rgb_test --sayyes --board pico-ice

# Build the project using yosys/nextpnr
apio build

# Plug your pico-ice board and upload the blinky project to it
apio upload

echo "Deactivating virtual environment"
deactivate

echo ""
echo "Finished"
