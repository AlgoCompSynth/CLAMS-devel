#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

pushd $HOST_POKY_PATH
  source oe-init-build-env test_qemu_arm64_build
  sudo ../scripts/runqemu-gen-tapdevs 1000 4
popd

echo "Finished"
