#! /usr/bin/env bash

set -e

./apt_basic_devel.sh

for i in \
  cforth \
  gforth \
  pforth \
  zForth \
  c3 \
  c4
do
  pushd $i
    ./1_setup.sh
  popd
done

./linux_circuitpython.sh
./linux_micropython.sh
