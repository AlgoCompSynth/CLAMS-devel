#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE="$PWD/Logs/setup.log"
rm --force $LOGFILE

echo "Cloning fresh gforth project repository"
mkdir --parents $GFORTH_PATH
pushd $GFORTH_PATH/..
  rm --force --recursive $GFORTH_PATH
  /usr/bin/time git clone $GFORTH_URL \
    >> $LOGFILE 2>&1
popd

pushd $GFORTH_PATH

  echo "Building gforth"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  echo "Installing build dependencies"
  source ./install-deps.sh \
    >> $LOGFILE 2>&1

  echo "Building gforth and vmgen"
  /usr/bin/time ./BUILD-FROM-SCRATCH \
    >> $LOGFILE 2>&1

  echo "Building PDF documentation"
  cd doc
  /usr/bin/time make pdf \
    >> $LOGFILE 2>&1
  cd ..

  echo "Installing gforth and vmgen"
  sudo make install \
    >> $LOGFILE 2>&1

  date +"%F %T" \
    >> $LOGFILE 2>&1

popd

echo "Finished"
