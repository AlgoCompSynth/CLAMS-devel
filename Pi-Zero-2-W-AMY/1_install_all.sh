#! /usr/bin/env bash

set -e

for option in \
  terminal_setup \
  c4
do
  pushd $option
    ./1_setup.sh
  popd
done
