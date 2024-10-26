#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export DBX_CONTAINER_IMAGE="$CLAMS_CONTAINER_IMAGE"
export DBX_CONTAINER_NAME="$CLAMS_CONTAINER_NAME"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes"
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
export DBX_CONTAINER_HOSTNAME=$DBX_CONTAINER_NAME

echo ""
echo "Removing any existing distrobox container $DBX_CONTAINER_NAME"
distrobox rm --force $DBX_CONTAINER_NAME

echo "Removing any existing distrobox home directory $DBX_CONTAINER_DIRECTORY"
rm -rf $DBX_CONTAINER_DIRECTORY

echo "Pulling $DBX_CONTAINER_IMAGE"
podman pull $DBX_CONTAINER_IMAGE

echo "Creating distrobox $DBX_CONTAINER_NAME"
distrobox create \
  --image $DBX_CONTAINER_IMAGE \
  --name $DBX_CONTAINER_NAME \
  --hostname $DBX_CONTAINER_HOSTNAME \
  --pull \
  --home $DBX_CONTAINER_DIRECTORY \
  --additional-packages "systemd libpam-systemd software-properties-common time unminimize vim" \
  --init
  
echo ""
echo "Entering $DBX_CONTAINER_NAME."
echo "You do *not* have to type the above command!"
echo "This will take some time."
echo "It is downloading and installing basic packages."
echo ""
echo ""
distrobox enter "$DBX_CONTAINER_NAME"
