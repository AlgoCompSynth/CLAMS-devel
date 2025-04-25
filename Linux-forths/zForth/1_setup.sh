#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE="$PWD/Logs/setup.log"
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  libreadline-dev

echo "Cloning fresh zForth project repository"
mkdir --parents $ZFORTH_PATH
pushd $ZFORTH_PATH/..
  rm --force --recursive $ZFORTH_PATH
  /usr/bin/time git clone $ZFORTH_URL \
    >> $LOGFILE 2>&1
popd

pushd $ZFORTH_PATH

  echo "Building zForth"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  date +"%F %T" \
    >> $LOGFILE 2>&1

popd

echo "Installing $HOME/.local/bin/zforth"
cp zforth $HOME/.local/bin

echo "Finished"
