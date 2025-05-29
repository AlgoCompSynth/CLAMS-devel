#! /usr/bin/env bash

set -e

./apt_audio_base.sh
./install_yocto.sh
./install_raspi.sh
./apt_pkg_db_updates.sh
