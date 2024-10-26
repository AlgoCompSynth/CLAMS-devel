#! /bin/bash

set -e

echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/build_zeptoforth.log

echo "Prepending RISC-V and Arm compiler locations to PATH"
export PATH=$RISCV_COMPILER_PATH/bin:$ARM_COMPILER_PATH/bin:$PATH
$ARM_COMPILER_PATH/bin/arm-none-eabi-gcc --version
$RISCV_COMPILER_PATH/bin/riscv32-corev-elf-gcc --version
echo ""
echo "PATH: $PATH"

mkdir --parents $ZEPTOFORTH_PATH
pushd $ZEPTOFORTH_PATH/..
  echo "Cloning Zeptoforth"
  rm --force --recursive $ZEPTOFORTH_PATH
  git clone $ZEPTOFORTH_URL \
    >> $LOGFILE 2>&1
popd

pushd $ZEPTOFORTH_PATH
  echo "Building RP2040 'big' binaries"
  make rp2040_big \
    >> $LOGFILE 2>&1
  echo "Building RP2350 binaries"
  make rp2350 \
    >> $LOGFILE 2>&1
  echo "Building HTML docs"
  make html \
    >> $LOGFILE 2>&1
  echo "Building EPUB docs"
  make epub \
    >> $LOGFILE 2>&1
popd

echo "Finished"
