#! /usr/bin/env bash

set -e

echo ""
echo "*** Board Build Tests ***"

echo "Setting environment variables" | tee --append $LOGFILE
source ../set_container_envars.sh

export sample=$1
echo "sample: $sample"
sample_label=$(echo $sample | sed 's;/;-;g')

export LOGFILES=$PWD/Logs
mkdir --parents $LOGFILES
export LOGFILE=$LOGFILES/${sample_label}..test_boards.log
rm -fr $LOGFILE

echo "Activating \$ZEPHYR_OS_VENV" | tee --append $LOGFILE
source $ZEPHYR_VENV/bin/activate

  pushd $ZEPHYR_WORKSPACE > /dev/null

    for board in \
      native_sim \
      adafruit_macropad_rp2040 \
      bbc_microbit_v2 \
      pico_plus2/rp2350b/m33 \
      rpi_pico \
      rpi_pico2/rp2350a/m33 \
      teensy41 \
      wio_terminal \
      esp32c6_devkitc \
      pocketbeagle_2/am6232/m4 \
      pocketbeagle_2/am6232/a53 \
      rpi_4b \
      rpi_5 \
      beaglev_fire/polarfire/e51 \
      beaglev_fire/polarfire/u54 \
      beaglev_fire/polarfire/u54/smp \
      beagley_ai/j722s/main_r5f0_0 \
      beagley_ai/j722s/mcu_r5f0_0 \
      arty_a7/designstart_fpga_cortex_m1 \
      arty_a7/designstart_fpga_cortex_m3 \
      qemu_cortex_a53 \
      qemu_cortex_m0 \
      qemu_cortex_m3 \
      qemu_cortex_r5 \
      qemu_riscv32 \
      qemu_riscv64 \
      qemu_x86_64 \
      zybo

    do
      board_label=$(echo $board | sed 's;/;-;g')
      board_logfile="$LOGFILES/${sample_label}..${board_label}.log"
      board_build_dir="build_${sample_label}..${board_label}"
      echo "board: $board" | tee --append $LOGFILE

      set +e
      /usr/bin/time west build --pristine \
        --board $board \
        --build-dir $board_build_dir \
        samples/$sample \
        > $board_logfile 2>&1
      set -e

      lines=$(wc -l $board_logfile | sed 's/ .*$//')
      if (( $lines < 95 ))
      then
        echo "^^^ $lines lines:=FAILED!" | tee --append $LOGFILE
      fi

    done

  popd > /dev/null

deactivate

echo "*** Board Build Tests Finished ***" | tee --append $LOGFILE
