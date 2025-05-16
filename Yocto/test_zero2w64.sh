#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/test_zero2w64.log
rm --force $LOGFILE

export NEW_CONFIG_FILE=$PWD/test_zero2w64.conf

pushd $POKY_PATH
  echo "Initializing build directory"
  source oe-init-build-env test_zero2w64_build

  echo "Enabling artifact fetch"
  diff $NEW_CONFIG_FILE conf/local.conf || true
  cp $NEW_CONFIG_FILE conf/local.conf

  echo "Adding layer"
  bitbake-layers add-layer ../meta-raspberrypi

  echo "Building core-image-base"
  bitbake core-image-base

popd

echo "Finished"
