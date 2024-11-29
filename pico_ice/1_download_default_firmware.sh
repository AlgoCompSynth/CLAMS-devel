#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Creating fresh $PICO_ICE_PATH"
rm -fr $PICO_ICE_PATH
mkdir --parents $PICO_ICE_PATH
echo ""
pushd $PICO_ICE_PATH

  echo "Downloading $PICO_ICE_FIRMWARE_UF2"
  curl -sOL $PICO_ICE_FIRMWARE_URL

popd

echo "Finished"
