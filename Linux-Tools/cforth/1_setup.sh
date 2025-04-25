#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE="$PWD/Logs/setup.log"
rm --force $LOGFILE

echo "Cloning fresh cforth project repository"
mkdir --parents $CFORTH_PATH
pushd $CFORTH_PATH/..
  rm --force --recursive $CFORTH_PATH
  /usr/bin/time git clone $CFORTH_URL \
    >> $LOGFILE 2>&1
popd

pushd $CFORTH_PATH/build/host-serial-linux64

  echo "Building host serial cforth"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  echo "Installing host serial cforth globally"
  sudo cp cforth forth app.dic /usr/local/bin/
  date +"%F %T" \
    >> $LOGFILE 2>&1
popd

echo "Finished"
