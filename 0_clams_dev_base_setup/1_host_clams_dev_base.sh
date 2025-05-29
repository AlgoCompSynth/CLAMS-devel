#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
echo "Creating and starting distrobox container"
echo "This will take some time to install basic packages"
echo ""
echo ""
echo ""
sleep 5
distrobox assemble create

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/clams_dev_base.log
rm --force $LOGFILE

podman logs CLAMS-dev-base \
  >> $LOGFILE 2>&1

echo "Finished"
