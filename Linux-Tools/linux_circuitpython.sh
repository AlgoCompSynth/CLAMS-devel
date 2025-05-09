#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_circuitpython.log
rm --force $LOGFILE

mkdir --parents $CIRCUITPYTHON_PATH

pushd $CIRCUITPYTHON_PATH/..
  echo "Cloning CircuitPython"
  rm -fr $CIRCUITPYTHON_PATH
  /usr/bin/time git clone $CIRCUITPYTHON_URL \
    >> $LOGFILE 2>&1
popd

pushd $CIRCUITPYTHON_PATH
  echo "Creating / activating fresh virtual environment $CIRCUITPYTHON_VENV/"
  rm --force --recursive $CIRCUITPYTHON_VENV/
  python3 -m venv $CIRCUITPYTHON_VENV/ --upgrade-deps
  source $CIRCUITPYTHON_VENV/bin/activate

  echo "Installing Python requirements"
  /usr/bin/time pip3 install --upgrade -r requirements-dev.txt \
    >> $LOGFILE 2>&1
  /usr/bin/time pip3 install --upgrade -r requirements-doc.txt \
    >> $LOGFILE 2>&1
  /usr/bin/time pip3 install --upgrade huffman \
    >> $LOGFILE 2>&1

  echo "Building mpy-cross"
  /usr/bin/time make -C mpy-cross \
    >> $LOGFILE 2>&1
popd

pushd $CIRCUITPYTHON_PATH/ports/unix
  echo "Fetching submodules"
  /usr/bin/time make submodules -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Building Unix port"
  export VARIANT=standard
  /usr/bin/time make -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Copying circuitpython to $HOME/.local/bin"
  cp build-standard/micropython $HOME/.local/bin/circuitpython
popd

echo "Deactivating virtual environment"
deactivate

echo "Finished"
