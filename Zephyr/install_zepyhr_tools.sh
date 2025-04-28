#! /usr/bin/env bash

set -e

# https://docs.zephyrproject.org/latest/develop/getting_started/index.html

echo "Setting environment variables"
source set_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_zepyhr_tools.log
rm -fr $LOGFILE

echo "Creating fresh $ZEPHYR_PROJECT"
rm --force --recursive $ZEPHYR_PROJECT; mkdir --parents $ZEPHYR_PROJECT

echo "Creating / activating virtual environment"
python3 -m venv $ZEPHYR_VENV --upgrade-deps
source $ZEPHYR_VENV/bin/activate

  echo "Installing west"
  /usr/bin/time pip install west \
    >> $LOGFILE 2>&1

  echo "Initializing Zephyr project"
  /usr/bin/time west init $ZEPHYR_PROJECT \
    >> $LOGFILE 2>&1

  pushd $ZEPHYR_PROJECT
    echo "Updating Zephyr project"
    /usr/bin/time west update \
      >> $LOGFILE 2>&1

    echo "Exporting Zephyr CMake package"
    /usr/bin/time west zephyr-export \
      >> $LOGFILE 2>&1

    echo "Installing Python dependencies"
    /usr/bin/time west packages pip --install \
      >> $LOGFILE 2>&1

  popd

  pushd $ZEPHYR_SDK

    echo "Installing Zephyr SDK"
    /usr/bin/time west sdk install \
      >> $LOGFILE 2>&1

  popd

deactivate

echo "Finished"
