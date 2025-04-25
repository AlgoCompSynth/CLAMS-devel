#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ./set_envars

export PIO_ENVIRONMENT=${1-rpipico}
export BOARD_TAG=${2-""}
export LOGFILE="$PWD/${PIO_ENVIRONMENT}${BOARD_TAG}.log"
rm --force $LOGFILE

echo "Activating PlatformIO virtual environment"
source $PLATFORMIO_VENV/bin/activate

pushd $CFORTH_PATH
  date +"%F %T" \
    >> $LOGFILE 2>&1

  echo "Listing USB devices"
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  lsusb --tree --verbose \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  ls -l /dev/ttyACM* \
    >> $LOGFILE 2>&1 || true
  ls -l /dev/ttyUSB* \
    >> $LOGFILE 2>&1 || true
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1

  echo "Building and uploading"
  /usr/bin/time pio run --verbose \
    --environment $PIO_ENVIRONMENT \
    --target upload \
    >> $LOGFILE 2>&1

  echo "Sleeping 20 seconds for devices to settle"
  sleep 20

  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  echo "Listing USB devices"
  lsusb --tree --verbose \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  ls -l /dev/ttyACM* \
    >> $LOGFILE 2>&1 || true
  ls -l /dev/ttyUSB* \
    >> $LOGFILE 2>&1 || true
  date +"%F %T" \
    >> $LOGFILE 2>&1
popd

echo "Deactivating"
deactivate

echo "Fetching firmware file"
cp $CFORTH_PATH/.pio/build/$PIO_ENVIRONMENT/firmware.elf "${PIO_ENVIRONMENT}${BOARD_TAG}.elf"

echo "Active TTYs"
ls -l /dev/ttyACM* || true
ls -l /dev/ttyUSB* || true

echo "Finished"
