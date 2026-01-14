#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE="$PWD/Logs/setup.log"
rm --force $LOGFILE

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  lib32stdc++-13-dev \
  >> $LOGFILE 2>&1

echo "Cloning fresh c4a project repository"
mkdir --parents $C4A_PATH
pushd $C4A_PATH/..
  rm --force --recursive $C4A_PATH
  /usr/bin/time git clone $C4A_URL \
    >> $LOGFILE 2>&1
popd

pushd $C4A_PATH

  echo "Building c4a"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  date +"%F %T" \
    >> $LOGFILE 2>&1

  echo "Installing c4a"
  cp c4a $HOME/.local/bin

popd

echo "Finished"
