#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_basic_devel.sh

for option in \
  cforth \
  gforth \
  pforth \
  zForth \
  c3 \
  c4
do
  pushd $option
    ./1_setup.sh
  popd
done

./linux_circuitpython.sh
./linux_micropython.sh
./apt_pkg_db_updates.sh
