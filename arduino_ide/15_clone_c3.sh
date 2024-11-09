#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/15_clone_c3.log
rm --force $LOGFILE

echo "Cloning fresh c3 project repository"
rm --force --recursive c3
/usr/bin/time git clone https://github.com/AlgoCompSynth/c3.git \
  >> $LOGFILE 2>&1

echo "Finished"
