#! /usr/bin/env bash

set -e

./apt_audio_base.sh
./linux_dependencies.sh
./install_zepyhr_tools.sh
./apt_pkg_db_updates.sh
