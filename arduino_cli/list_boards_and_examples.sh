#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Updating indexes"
arduino-cli update

echo "Listing cores to core_list.txt"
arduino-cli core list --no-color > core_list.txt

echo "Listing boards to board_list.txt"
arduino-cli board listall --no-color > board_list.txt

echo "Listing libraries to library_list.txt"
arduino-cli lib list --no-color > library_list.txt

echo "Listing examples to example_list.txt"
arduino-cli lib examples --no-color > example_list.txt

echo "Finished"
