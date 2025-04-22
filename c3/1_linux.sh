#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE="$PWD/Logs/linux.log"
rm --force $LOGFILE

echo "Cloning fresh c3 project repository"
mkdir --parents $C3_PATH
pushd $C3_PATH/..
  rm --force --recursive $C3_PATH
  /usr/bin/time git clone $C3_URL \
    >> $LOGFILE 2>&1
popd

pushd $C3_PATH

  echo "Building c3"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  date +"%F %T" \
    >> $LOGFILE 2>&1

popd

echo "Installing c3"
cp c3 $HOME/.local/bin

echo "Finished"
