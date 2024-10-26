#! /usr/bin/env bash

set -e

# https://docs.zephyrproject.org/latest/develop/getting_started/index.html

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE="$PWD/1_zephyr_project_setup.log"
rm --force $LOGFILE

echo "Creating fresh Zephyr OS project directory $ZEPHYR_OS_PROJECT"
rm --force --recursive $ZEPHYR_OS_PROJECT
mkdir --parents  $ZEPHYR_OS_PROJECT

echo "Creating fresh virtual environment $ZEPHYR_OS_VENV"
rm -fr $ZEPHYR_OS_VENV
python3 -m venv $ZEPHYR_OS_VENV --upgrade-deps
echo "Activating virtual environment $ZEPHYR_OS_VENV"
source $ACTIVATE_ZEPHYR_OS_VENV

echo "Installing 'west' with pip"
# https://docs.platformio.org/en/latest/core/installation/methods/pypi.html#installation-pypi
/usr/bin/time python3 -m pip install --upgrade west \
  >> $LOGFILE 2>&1

echo "west init"
/usr/bin/time west init $ZEPHYR_OS_PROJECT \
  >> $LOGFILE 2>&1
pushd $ZEPHYR_OS_PROJECT
  echo "west update"
  /usr/bin/time west update \
    >> $LOGFILE 2>&1
  echo "west zephyr-export"
  /usr/bin/time west zephyr-export \
    >> $LOGFILE 2>&1
  echo "Python requirements"
  /usr/bin/time pip install -r $ZEPHYR_OS_PROJECT/zephyr/scripts/requirements.txt \
    >> $LOGFILE 2>&1
popd

echo "Installing Zephyr OS SDK"
pushd /tmp
  rm --force --recursive zephyr*
  echo "Downloading tarball"
  wget --quiet $ZEPHYR_OS_SDK_URL
  echo "Validating checksum"
  wget --quiet -O - $ZEPHYR_OS_SDK_SHASUM | shasum --check --ignore-missing
popd

pushd $ZEPHYR_OS_SDK_DEST
  echo "Extracting"
  rm --force --recursive zephyr*
  /usr/bin/time tar --extract --file /tmp/$ZEPHYR_OS_SDK_TARBALL \
    >> $LOGFILE 2>&1
  echo "Setting up"
  cd zephyr-sdk*
    ./setup.sh -t all -h -c
  cd ..
popd

echo "Deactivating virtual environment $ZEPHYR_OS_VENV"
deactivate

echo "Finished"
