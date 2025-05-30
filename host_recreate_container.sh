#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export CTN_NAME=`basename "$(pwd)"`
echo "CTN_NAME: $CTN_NAME"
export CTN_HOME=$DBX_CONTAINER_HOME_PREFIX/$CTN_NAME
echo "CTN_HOME: $CTN_HOME"

echo "Stopping base container:"
distrobox stop --yes $BASE_CONTAINER_NAME || true
echo ""
echo "Stopping any existing container:"
distrobox stop --yes $CTN_NAME || true
echo "Removing any existing container home"
rm --force --recursive $CTN_HOME
echo "Copying base container home"
cp -rp $BASE_CONTAINER_HOME $CTN_HOME

echo "Creating distrobox.ini"
sed "s/BASE_CONTAINER_NAME/$BASE_CONTAINER_NAME/" ../distrobox.template \
  | sed "s/CTN_NAME/$CTN_NAME/" \
  > distrobox.ini

echo "Creating and starting distrobox container"
echo "This will take some time to install basic packages"
echo ""
echo ""
echo ""
sleep 5
distrobox assemble create

echo "Entering $CTN_NAME"
distrobox enter $CTN_NAME -- ./2_install_all.sh

echo "Leaving $CTN_NAME"

echo "Finished"
