#! /usr/bin/env bash

set -e

./apt_basic_devel.sh

for option in \
  c3 \
  c4 \
  cforth \
  pforth \
  zForth \
  gforth
do
  pushd $option
    ./1_setup.sh
  popd
done

./linux_circuitpython.sh
./linux_micropython.sh
./apt_pkg_db_updates.sh
