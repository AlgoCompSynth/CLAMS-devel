#! /usr/bin/env bash

set -e

./linux_dependencies.sh
./install_buildroot.sh
../apt_pkg_db_updates.sh
