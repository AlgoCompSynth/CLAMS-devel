#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_das_u_boot.log
rm --force $LOGFILE

mkdir --parents $DAS_U_BOOT_PATH
pushd $DAS_U_BOOT_PATH/..
  echo "Cloning Das-U-Boot"
  rm -fr $DAS_U_BOOT_PATH
  /usr/bin/time git clone $DAS_U_BOOT_URL \
    >> $LOGFILE 2>&1
popd

echo "Finished"
