#! /usr/bin/env bash

set -e

echo ""
echo "*** Board Build Tests ***"

export LOGFILES=$PWD/Logs
mkdir --parents $LOGFILES
export LOGFILE=$LOGFILES/build_tests.log
rm -fr $LOGFILE

echo "Setting environment variables" | tee --append $LOGFILE
source ../set_container_envars.sh

echo "Activating \$ZEPHYR_OS_VENV" | tee --append $LOGFILE
source $ZEPHYR_VENV/bin/activate

  pushd $ZEPHYR_WORKSPACE > /dev/null

    for board in \
      adafruit_macropad_rp2040 \
      bbc_microbit_v2 \
      beaglev_fire/polarfire/e51 \
      beaglev_fire/polarfire/u54 \
      beaglev_fire/polarfire/u54/smp \
      beagley_ai/j722s/main_r5f0_0 \
      beagley_ai/j722s/mcu_r5f0_0 \
      pocketbeagle_2/am6232/m4 \
      pocketbeagle_2/am6232/a53 \
      arty_a7/designstart_fpga_cortex_m1 \
      arty_a7/designstart_fpga_cortex_m3 \
      zybo \
      native_sim \
      pico_plus2/rp2350b/m33 \
      teensy41 \
      qemu_cortex_a53 \
      qemu_cortex_m0 \
      qemu_cortex_m3 \
      qemu_riscv32 \
      qemu_riscv64 \
      qemu_x86_64 \
      rpi_5 \
      rpi_pico \
      rpi_pico2/rp2350a/m33 \
      wio_terminal \
      esp32c6_devkitc

    do
      echo "Build test: $board" | tee --append $LOGFILE
      board_logfile=$(echo $board | sed 's;/;-;g')
      board_build_dir="build_$board"

      set +e
      /usr/bin/time west build --pristine \
        --board $board \
        --build-dir $board_build_dir \
        samples/hello_world \
        > $LOGFILES/$board_logfile.log 2>&1
      set -e

      lines=$(wc -l $LOGFILES/$board_logfile.log | sed 's/ .*$//')
      if (( $lines < 95 ))
      then
        echo "^^^ $lines lines:=FAILED!" | tee --append $LOGFILE
      fi

    done

  popd > /dev/null

deactivate

echo "*** Board Build Tests Finished ***" | tee --append $LOGFILE
