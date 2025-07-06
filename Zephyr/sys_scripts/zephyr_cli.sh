#! /usr/bin/env bash

set -e

echo ""
echo "*** Zephyr Command Line Tools ***"

# https://docs.zephyrproject.org/latest/develop/getting_started/index.html

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/zephyr_cli.log
rm -fr $LOGFILE
export BOARD_LIST=$PWD/west-boards.txt

echo "Setting environment variables" | tee --append $LOGFILE
source ../set_container_envars.sh

echo "Creating fresh \$ZEPHYR_PROJECT" | tee --append $LOGFILE
rm --force --recursive $ZEPHYR_PROJECT; mkdir --parents $ZEPHYR_PROJECT

echo "Creating / activating \$ZEPHYR_OS_VENV" | tee --append $LOGFILE
python3 -m venv $ZEPHYR_VENV --upgrade-deps
source $ZEPHYR_VENV/bin/activate

  echo "Installing west" | tee --append $LOGFILE
  /usr/bin/time pip install west \
    >> $LOGFILE 2>&1

  echo "Initializing Zephyr project" | tee --append $LOGFILE
  /usr/bin/time west init $ZEPHYR_PROJECT \
    >> $LOGFILE 2>&1

  pushd $ZEPHYR_PROJECT > /dev/null
    echo "Updating Zephyr project" | tee --append $LOGFILE
    /usr/bin/time west update \
      >> $LOGFILE 2>&1

    echo "Exporting Zephyr CMake package" | tee --append $LOGFILE
    /usr/bin/time west zephyr-export \
      >> $LOGFILE 2>&1

    echo "Installing Python dependencies" | tee --append $LOGFILE
    /usr/bin/time west packages pip --install \
      >> $LOGFILE 2>&1

    echo "Installing Zephyr SDK" | tee --append $LOGFILE
    rm --force --recursive $ZEPHYR_SDK_PATH
    /usr/bin/time west sdk install \
      >> $LOGFILE 2>&1

    echo "Listing supported boards" | tee --append $LOGFILE
    west boards | sort | tee --append $LOGFILE > $BOARD_LIST

  popd > /dev/null

  pushd $ZEPHYR_SDK_PATH > /dev/null
    echo "Setting up Zephyr SDK" | tee --append $LOGFILE
    /usr/bin/time ./setup.sh -t all -h -c \
      >> $LOGFILE 2>&1
  popd > /dev/null

deactivate

echo "*** Zephyr Command Line Tools Finished ***" | tee --append $LOGFILE
