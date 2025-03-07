#! /usr/bin/env bash

set -e

./edit_swap_size.sh
./add_audio_midi_gadgets.sh
./1_global_installs.sh
./install_chuck.sh
./install_pforth.sh
