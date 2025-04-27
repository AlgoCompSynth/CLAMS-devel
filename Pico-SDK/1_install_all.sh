#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_basic_devel.sh
./pico_compilers.sh
./pico_toolchain.sh
./pico_ice_micropython.sh
