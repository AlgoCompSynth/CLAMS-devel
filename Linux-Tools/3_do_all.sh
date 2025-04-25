#! /usr/bin/env bash

set -e

./linux_circuitpython.sh
./linux_micropython.sh

for i in \
  c3 \
  c4 \
  gforth \
  pforth \
  zForth
do
  pushd $i
    ./1_setup.sh
  popd
done
