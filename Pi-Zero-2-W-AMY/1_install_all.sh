#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

for option in \
  c4a \
  cforth \
  pforth \
  zForth \
  gforth
do
  pushd $option
    distrobox enter "$DBX_CONTAINER_NAME" -- ./1_setup.sh
  popd
done

distrobox enter "$DBX_CONTAINER_NAME" -- ./linux_circuitpython.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./linux_micropython.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./apt_pkg_db_updates.sh
