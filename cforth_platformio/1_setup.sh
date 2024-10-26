#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ./set_envars
export LOGFILE="$PWD/1_setup.log"
rm --force $LOGFILE

echo "Installing python3-pip and python3-venv if necessary"
sudo apt-get install -y \
  python3-pip \
  python3-venv \
  >> $LOGFILE 2>&1

echo "Removing $HOME/.platformio"
rm --force --recursive $HOME/.platformio

echo "Creating fresh virtual environment $PLATFORMIO_VENV"
rm --force --recursive $PLATFORMIO_VENV
python3 -m venv $PLATFORMIO_VENV --upgrade-deps

echo "Activating virtual environment $PLATFORMIO_VENV"
source $PLATFORMIO_VENV/bin/activate

echo "Installing PlatformIO core with pip"
# https://docs.platformio.org/en/latest/core/installation/methods/pypi.html#installation-pypi
/usr/bin/time python3 -m pip install --upgrade platformio \
  >> $LOGFILE 2>&1
pio --version

echo "Cloning fresh cforth project repository"
mkdir --parents $CFORTH_PATH
pushd $CFORTH_PATH/..
  rm --force --recursive $CFORTH_PATH
  /usr/bin/time git clone $CFORTH_URL \
    >> $LOGFILE 2>&1
popd

echo "Appending test envioronments to $CFORTH_PATH/platformio.ini"
cat testing_platformio.ini >> $CFORTH_PATH/platformio.ini

pushd $CFORTH_PATH

  echo "Building host cforth"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  /usr/bin/time pio run --verbose \
    >> $LOGFILE 2>&1
  date +"%F %T" \
    >> $LOGFILE 2>&1

popd

echo "Installing RP2040 platform"
pio platform install \
  "https://github.com/maxgerhardt/platform-raspberrypi.git"

echo "Installing ESP32 platform"
pio platform install \
  "https://github.com/pioarduino/platform-espressif32/archive/refs/tags/51.03.05.zip"

echo "Installing Teensy platform"
pio platform install teensy

echo "Listing supported boards"
pio boards > board_list.txt

echo "Deactivating"
deactivate

echo "Finished"
