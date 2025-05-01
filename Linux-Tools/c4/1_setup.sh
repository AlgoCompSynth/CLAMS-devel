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
  >> $LOGFILE 2>&1

echo "Cloning fresh c4 project repository"
mkdir --parents $C4_PATH
pushd $C4_PATH/..
  rm --force --recursive $C4_PATH
  /usr/bin/time git clone $C4_URL \
    >> $LOGFILE 2>&1
popd

pushd $C4_PATH

  echo "Building c4"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  export ARCH=64
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  date +"%F %T" \
    >> $LOGFILE 2>&1

popd

echo "Installing c4"
cp c4 $HOME/.local/bin

echo "Finished"
