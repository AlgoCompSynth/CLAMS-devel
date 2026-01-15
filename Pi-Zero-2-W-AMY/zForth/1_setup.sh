#! /usr/bin/env bash

set -e

echo ""
echo "* zForth *"
source ../set_envars
export LOGFILE="$LOGFILES/zForth.log"
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  libreadline-dev \
  >> $LOGFILE 2>&1

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

echo "Installing $LOCALBIN/zforth"
cp zforth $LOCALBIN

echo "* Finished zForth *"
