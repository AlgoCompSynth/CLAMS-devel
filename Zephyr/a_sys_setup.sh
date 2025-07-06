#! /usr/bin/env bash

set -e

echo ""
echo "** System Setup **"

echo "Setting environment variables"
source set_container_envars.sh

echo "Clearing logfiles"
rm --force --recursive sys_scripts/Logs

pushd sys_scripts > /dev/null
  ./apt_system_upgrade.sh
  ./apt_linux_dependencies.sh
  ./terminal_setup.sh
  ./zephyr_cli.sh
  ./apt_pkg_db_updates.sh

  for sample in \
    'basic/blinky' \
    'hello_world' \
    'subsys/usb/midi' \
    'subsys/usb/cdc_acm' \
    'subsys/usb/audio/headphones_microphone'
  do
    ./test_boards.sh "$sample"
  done

  pushd $ZEPHYR_WORKSPACE > /dev/null
  du -sk build_* | sort -k 1 -n > $HOME/build-sizes.log
  popd > /dev/null
  wc -l Logs/*.log | grep -e "\.\." | sort -k 1 -n > $HOME/log-lines.log

popd > /dev/null

echo "** System Setup Finished **"
