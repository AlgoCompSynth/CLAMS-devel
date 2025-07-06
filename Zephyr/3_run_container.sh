#! /usr/bin/env bash

set -e

echo ""
echo "* Run Container *"

echo "Setting environment variables"
source set_container_envars.sh

cd $DBX_CONTAINER_DIRECTORY
/usr/bin/time distrobox enter "$DBX_CONTAINER_NAME" -- ./enter.sh

echo "* Run Container Finished *"
