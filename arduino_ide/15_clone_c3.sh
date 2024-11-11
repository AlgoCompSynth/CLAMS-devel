#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/15_clone_c3.log
rm --force $LOGFILE

echo "Cloning fresh c3 project repository"
rm --force --recursive c3
/usr/bin/time git clone https://github.com/AlgoCompSynth/c3.git \
  >> $LOGFILE 2>&1

echo "Copying Forth files for upload"
pushd c3
  mkdir --parents data
  cp *.fth data/
popd

echo "Finished"
