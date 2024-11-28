#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Listing connected boards"
arduino-cli board list

echo "Finished"
