#! /usr/bin/env bash

set -e

./linux_dependencies.sh
./install_yocto.sh
./install_raspi.sh
../apt_pkg_db_updates.sh
