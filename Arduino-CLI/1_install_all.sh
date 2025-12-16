#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

distrobox enter "$DBX_CONTAINER_NAME" -- ./linux_dependencies.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./arduino_ide.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./arduino_cli.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./arduino_pico.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./amy.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./teensyduino.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./arduino_audio_tools.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./apt_pkg_db_updates.sh
distrobox enter "$DBX_CONTAINER_NAME" -- ./list_boards_and_examples.sh


