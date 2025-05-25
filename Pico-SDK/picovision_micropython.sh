#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/picovision_micropython.log
rm --force $LOGFILE

rm --force --recursive $PICOVISION_MICROPYTHON_PATH
mkdir --parents $PICOVISION_MICROPYTHON_EXAMPLES_PATH
echo ""
pushd $PICOVISION_MICROPYTHON_PATH
  echo "Downloading uf2s and examples"
  curl -sOL $PICOVISION_MICROPYTHON_URL
  curl -sOL $PICOVISION_MICROPYTHON_WIDESCREEN_URL
  curl -sOL $PICOVISION_MICROPYTHON_EXAMPLES_URL
popd > /dev/null

echo ""
pushd $PICOVISION_MICROPYTHON_EXAMPLES_PATH
  unzip ../pimoroni-*.zip
popd > /dev/null

mkdir --parents $PICOVISION_REPO_PATH
echo ""
pushd $PICOVISION_REPO_PATH/..
  echo "Cloning picovision repo"
  rm --force --recursive $PICOVISION_REPO_PATH
  git clone --quiet $PICOVISION_REPO_URL
popd > /dev/null

echo "Finished"
