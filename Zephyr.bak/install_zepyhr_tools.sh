#! /usr/bin/env bash

set -e

# https://docs.zephyrproject.org/latest/develop/getting_started/index.html

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_zepyhr_tools.log
rm -fr $LOGFILE

echo "Setting environment variables" | tee --append $LOGFILE
source set_envars

echo "Creating fresh $ZEPHYR_PROJECT" | tee --append $LOGFILE
rm --force --recursive $ZEPHYR_PROJECT; mkdir --parents $ZEPHYR_PROJECT

echo "Creating / activating virtual environment" | tee --append $LOGFILE
python3 -m venv $ZEPHYR_VENV --upgrade-deps
source $ZEPHYR_VENV/bin/activate

  echo "Installing west" | tee --append $LOGFILE
  /usr/bin/time pip install west \
    >> $LOGFILE 2>&1

  echo "Initializing Zephyr project" | tee --append $LOGFILE
  /usr/bin/time west init $ZEPHYR_PROJECT \
    >> $LOGFILE 2>&1

  pushd $ZEPHYR_PROJECT
    echo "Updating Zephyr project" | tee --append $LOGFILE
    /usr/bin/time west update \
      >> $LOGFILE 2>&1

    echo "Exporting Zephyr CMake package" | tee --append $LOGFILE
    /usr/bin/time west zephyr-export \
      >> $LOGFILE 2>&1

    echo "Installing Python dependencies" | tee --append $LOGFILE
    /usr/bin/time west packages pip --install \
      >> $LOGFILE 2>&1

  popd

  pushd $ZEPHYR_SDK

    echo "Installing Zephyr SDK" | tee --append $LOGFILE
    /usr/bin/time west sdk install \
      >> $LOGFILE 2>&1

  popd

deactivate

echo "Finished" | tee --append $LOGFILE
