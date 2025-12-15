#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

distrobox enter "$DBX_CONTAINER_NAME" -- ./linux_dependencies.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./pico_compilers.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./pico_repos.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./pico_utilities.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./pico_ice_micropython.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./picovision_micropython.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./apt_pkg_db_updates.sh
