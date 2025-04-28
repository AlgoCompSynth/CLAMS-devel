#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_basic_devel.sh

./install_zepyhr_tools.sh

./apt_pkg_db_updates.sh
