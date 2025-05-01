#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/pico_repos.log"
rm --force $LOGFILE

export SUPPORTED_BOARDS="$PWD/supported_boards.txt"
echo "Creating fresh $PICO_SDK_REPOS"
rm -fr $PICO_SDK_REPOS
mkdir --parents $PICO_SDK_REPOS

pushd $PICO_SDK_REPOS

  echo ""
  echo "Cloning Raspberry Pi Pico SDK repositories"
  git config --global advice.detachedHead false
  git clone --quiet $PICO_SDK_URL
  git clone --quiet $PICO_EXAMPLES_URL
  git clone --quiet $PICO_EXTRAS_URL
  git clone --quiet $PICO_PLAYGROUND_URL
  git clone --quiet $PIMORONI_PICO_URL
  git clone --quiet $FREERTOS_KERNEL_URL

  echo ""
  echo "Listing supported boards to $SUPPORTED_BOARDS"
  ls -1 $PICO_SDK_REPOS/pico-sdk/src/boards/include/boards | sort -u > $SUPPORTED_BOARDS

popd

echo "Finished"
