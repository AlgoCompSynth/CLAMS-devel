#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/test_qemu.log
rm --force $LOGFILE

export NEW_CONFIG_FILE=$PWD/test_qemu.conf

pushd $POKY_PATH
  echo "Initializing build directory"
  source oe-init-build-env test_qemu_build

  echo "Enabling artifact fetch"
  diff $NEW_CONFIG_FILE conf/local.conf || true
  cp $NEW_CONFIG_FILE conf/local.conf

  echo "Building core-image-full-cmdline"
  bitbake core-image-full-cmdline

  echo "Testing core-image-full-cmdline"
  runqemu qemux86-64
popd

echo "Finished"
