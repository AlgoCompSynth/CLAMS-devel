#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/selected_examples.log
rm --force $LOGFILE

echo "Logging build failure messages"
grep "^make" ~/CLAMS_base/pico_repos/pico-examples/build_*/make.log \
  >> $LOGFILE 2>&1

echo "Creating $CLAMS_BASE/selected_examples.zip"
pushd $PICO_EXAMPLES_PATH
  for suffix in uf2 elf dis
  do
    /usr/bin/time zip -9r $CLAMS_BASE/selected_examples.zip `find . -name "blink.$suffix"` \
      >> $LOGFILE 2>&1
    /usr/bin/time zip -9r $CLAMS_BASE/selected_examples.zip `find . -name "hello_*.$suffix"` \
      >> $LOGFILE 2>&1
    /usr/bin/time zip -9r $CLAMS_BASE/selected_examples.zip `find . -name "flash_*.$suffix"` \
      >> $LOGFILE 2>&1
    /usr/bin/time zip -9r $CLAMS_BASE/selected_examples.zip `find . -name "tinyusb*.$suffix"` \
      >> $LOGFILE 2>&1
  done
popd

pushd $PICO_PLAYGROUND_PATH
  for suffix in uf2 elf dis
  do
    /usr/bin/time zip -9r $CLAMS_BASE/selected_examples.zip `find . -name "hello_*.$suffix"` \
      >> $LOGFILE 2>&1
    /usr/bin/time zip -9r $CLAMS_BASE/selected_examples.zip `find . -name "sine_wave*.$suffix"` \
      >> $LOGFILE 2>&1
  done
popd

pushd $PIMORONI_PICO_PATH
  for suffix in uf2 elf dis
  do
    /usr/bin/time zip -9r $CLAMS_BASE/selected_examples.zip `find . -name "audio.$suffix"` \
      >> $LOGFILE 2>&1
  done
popd

echo "Unpacking $CLAMS_BASE/selected_examples.zip"
pushd $CLAMS_BASE
  rm -fr build_*
  /usr/bin/time unzip selected_examples.zip \
    >> $LOGFILE 2>&1
popd

echo "Finished"
