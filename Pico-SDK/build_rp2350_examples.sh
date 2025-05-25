#! /bin/bash

set -e

function sdk_build {
  target="$dir/build_${PICO_BOARD}_${PICO_PLATFORM}"
  repo=`echo $dir | sed 's;^.*/;;'`
  zipfile="${repo}_${PICO_BOARD}_${PICO_PLATFORM}.zip"
  pushd $dir > /dev/null

    echo ""
    echo "Re-creating $target"
    rm -fr $target; mkdir $target; pushd $target > /dev/null

      echo "Configuring $target"
      cmake .. \
        -DCMAKE_BUILD_TYPE=Debug \
        -DPICO_SDK_POST_LIST_DIRS=$PICO_EXTRAS_PATH \
        > cmake.log 2>&1

      echo "Compiling $target"
      if [ "${#SJMAKE}" -gt "0" ]
      then
        echo "Single-job 'make' enabled"
        /usr/bin/time make --keep-going -j1 > make.log 2>&1
      else
        /usr/bin/time make --keep-going -j`nproc` > make.log 2>&1
      fi

      popd > /dev/null

    popd > /dev/null

}

echo ""
echo ""
echo "If you want to run in single-job 'make' mode for troubleshooting,"
echo "restart this script with a non-empty parameter string as the first"
echo "argument."
sleep 10
export SJMAKE=$1

echo "Setting environment variables"
source ../set_pico_envars
echo "Setting WiFi credentials - some examples need them to build"
export WIFI_SSID="Bogus"
export WIFI_PASSWORD="Also bogus"
echo "Prepending RISC-V and Arm compiler locations to PATH"
export PATH=$RISCV_COMPILER_PATH/bin:$ARM_COMPILER_PATH/bin:$PATH
$ARM_COMPILER_PATH/bin/arm-none-eabi-gcc --version
$RISCV_COMPILER_PATH/bin/riscv32-corev-elf-gcc --version
echo ""
echo "PATH: $PATH"

echo ""
echo ""
echo "Building the rp2350 examples"
for dir in \
  $PICO_EXAMPLES_PATH \
  $PICO_PLAYGROUND_PATH
do

  for board in \
    pico2 \
    pimoroni_pico_plus2_rp2350 \
    pimoroni_pico_plus2_w_rp2350 \
    ilabs_challenger_rp2350_bconnect \
    ilabs_challenger_rp2350_wifi_ble \
    sparkfun_promicro_rp2350 \
    pico2_w \
    sparkfun_thingplus_rp2350 \
    adafruit_feather_rp2350
  do
    export PICO_BOARD=$board

    for platform in rp2350-arm-s rp2350-riscv
    do
      export PICO_PLATFORM=$platform
      set +e
      sdk_build $SJMAKE
      set -e
    done

  done

done

echo "Finished"
