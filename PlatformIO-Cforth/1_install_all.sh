#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

distrobox enter "$DBX_CONTAINER_NAME" -- ./linux_dependencies.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./platformio_cforth_base.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./apt_pkg_db_updates.sh
