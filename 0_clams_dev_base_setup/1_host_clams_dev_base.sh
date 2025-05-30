#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export CTN_NAME=$BASE_CONTAINER_NAME
echo "CTN_NAME: $CTN_NAME"
export CTN_HOME=$BASE_CONTAINER_HOME
echo "CTN_HOME: $CTN_HOME"

echo "Stopping any existing container"
distrobox stop --yes $CTN_NAME || true
echo "Removing any existing container home"
rm --force --recursive $CTN_HOME

echo "Creating and starting distrobox container"
echo "This will take some time to install basic packages"
echo ""
echo ""
echo ""
sleep 5
distrobox assemble create

echo "Entering container"
distrobox enter $CTN_NAME -- ./2_dbx_terminal_setup.sh

echo "Leaving container"

echo "Finished"
