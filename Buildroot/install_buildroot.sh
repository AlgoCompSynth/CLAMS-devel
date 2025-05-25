#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_buildroot.log
rm --force $LOGFILE

mkdir --parents $BUILDROOT_PATH
pushd $BUILDROOT_PATH/..
  echo "Cloning buildroot"
  rm -fr $BUILDROOT_PATH
  /usr/bin/time git clone $BUILDROOT_URL \
    >> $LOGFILE 2>&1
popd

echo "Finished"
