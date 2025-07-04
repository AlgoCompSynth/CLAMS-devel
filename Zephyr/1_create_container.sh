#! /usr/bin/env bash

set -e

echo ""
echo "* Create Container *"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/create_container.log
rm --force $LOGFILE

echo ""
echo "Setting environment variables"
source set_container_envars.sh

echo ""
echo "Stopping any existing distrobox container $DBX_CONTAINER_NAME"
distrobox stop --yes $DBX_CONTAINER_NAME || true

echo "Removing any existing distrobox home directory $DBX_CONTAINER_DIRECTORY"
rm -rf $DBX_CONTAINER_DIRECTORY

echo "Setting container and image names"
echo "[$DBX_CONTAINER_NAME]" > distrobox.ini
echo "image=$DBX_CONTAINER_IMAGE" >> distrobox.ini
cat distrobox.ini.$COMPUTE_MODE >> distrobox.ini

echo ""
echo "Creating container - installing the basic packages"
echo "will take some time."
/usr/bin/time distrobox assemble create --file distrobox.ini \
  >> $LOGFILE 2>&1

echo ""
echo "Copying \$HOME/.ssh into \$DBX_CONTAINER_DIRECTORY"
cp -rp $HOME/.ssh $DBX_CONTAINER_DIRECTORY
echo "Copying 'set_container_envars.sh' into \$DBX_CONTAINER_DIRECTORY"
cp -rp ./set_container_envars.sh $DBX_CONTAINER_DIRECTORY

echo "* Create Container Finished *"
