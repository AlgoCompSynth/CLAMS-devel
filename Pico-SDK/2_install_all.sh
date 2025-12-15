#! /usr/bin/env bash

set -e

./linux_dependencies.sh
./pico_compilers.sh
./pico_repos.sh
./pico_utilities.sh
./pico_ice_micropython.sh
./picovision_micropython.sh
./apt_pkg_db_updates.sh
