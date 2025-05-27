#! /usr/bin/env bash

set -e

./apt_basic_devel.sh
./linux_dependencies.sh
./platformio_cforth_base.sh
./apt_pkg_db_updates.sh
