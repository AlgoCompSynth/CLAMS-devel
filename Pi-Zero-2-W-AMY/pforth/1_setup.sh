#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE="$PWD/Logs/setup.log"
rm --force $LOGFILE

echo "Cloning fresh pforth project repository"
mkdir --parents $PFORTH_PATH
pushd $PFORTH_PATH/..
  rm --force --recursive $PFORTH_PATH
  /usr/bin/time git clone $PFORTH_URL \
    >> $LOGFILE 2>&1
popd

pushd $PFORTH_PATH

  echo "Building pforth"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  cmake . \
    >> $LOGFILE 2>&1
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  cp fth/pforth_standalone $HOME/.local/bin/
  ln -sf $HOME/.local/bin/pforth_standalone $HOME/.local/bin/pforth
  date +"%F %T" \
    >> $LOGFILE 2>&1

popd

echo "Finished"
