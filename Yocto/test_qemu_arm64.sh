#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/test_qemu_arm64.log
rm --force $LOGFILE

export NEW_CONFIG_FILE=$PWD/test_qemu_arm64.conf

pushd $POKY_PATH
  echo "Initializing build directory"
  source oe-init-build-env test_qemu_arm64_build

  echo "Setting configuration"
  diff $NEW_CONFIG_FILE conf/local.conf || true
  cp $NEW_CONFIG_FILE conf/local.conf

  echo "Building core-image-full-cmdline"
  /usr/bin/time bitbake core-image-full-cmdline \
    2>&1 | tee --append $LOGFILE

  echo "Testing core-image-full-cmdline"
  runqemu qemuarm64
popd

echo "Finished"
