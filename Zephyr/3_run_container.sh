#! /usr/bin/env bash

set -e

echo ""
echo "* Run Container *"

echo "Setting environment variables"
source set_container_envars.sh

/usr/bin/time distrobox enter "$DBX_CONTAINER_NAME" -- /bin/bash

echo "* Run Container Finished *"
