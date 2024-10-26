#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/2_pico_ice_sdk.log
rm --force $LOGFILE

echo "Creating fresh $PICO_ICE_SDK_PATH"
rm -fr $PICO_ICE_SDK_PATH
echo ""
pushd $PICO_ICE_PATH

  echo "Cloning $PICO_ICE_SDK_PATH"
  /usr/bin/time git clone $PICO_ICE_SDK_URL \
    >> $LOGFILE 2>&1

popd

echo "Finished"
