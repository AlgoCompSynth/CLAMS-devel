#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
export DBX_CONTAINER_IMAGE="quay.io/toolbx/ubuntu-toolbox:24.04"
export DBX_CONTAINER_NAME="Yocto"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes"
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
export DBX_CONTAINER_HOSTNAME=$DBX_CONTAINER_NAME

pushd $DBX_CONTAINER_DIRECTORY/poky
sudo ./scripts/runqemu-gen-tapdevs 1000 4
popd
