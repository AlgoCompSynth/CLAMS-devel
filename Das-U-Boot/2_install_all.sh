#! /usr/bin/env bash

set -e

./linux_dependencies.sh
./install_das_u_boot.sh
../apt_pkg_db_updates.sh
