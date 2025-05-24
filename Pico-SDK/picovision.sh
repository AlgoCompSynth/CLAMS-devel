#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/picovision.log
rm --force $LOGFILE

mkdir --parents $PICOVISION_PATH
pushd $PICOVISION_PATH
  echo "Downloading uf2s and examples"
  curl -sOL $PICOVISION_MICROPYTHON_URL
  curl -sOL $PICOVISION_MICROPYTHON_WIDESCREEN_URL
  curl -sOL $PICOVISION_MICROPYTHON_EXAMPLES_URL
popd > /dev/null

mkdir --parents $PICOVISION_MICROPYTHON_EXAMPLES_PATH
pushd $PICOVISION_MICROPYTHON_EXAMPLES_PATH
  unzip ../pimoroni-*.zip
popd > /dev/null

echo "Finished"
