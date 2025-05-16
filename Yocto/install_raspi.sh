#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_raspi.log
rm --force $LOGFILE

mkdir --parents $POKY_RASPI_PATH
pushd $POKY_RASPI_PATH/..
  echo "Cloning meta-raspberrypi"
  rm -fr $POKY_RASPI_PATH
  /usr/bin/time git clone $POKY_RASPI_URL \
    >> $LOGFILE 2>&1
  cd $POKY_RASPI_PATH
  git checkout -t origin/${POKY_VERSION} -b my-${POKY_VERSION}
popd

echo "Finished"
