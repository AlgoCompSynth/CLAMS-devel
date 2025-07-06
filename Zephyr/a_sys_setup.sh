#! /usr/bin/env bash

set -e

echo ""
echo "** System Setup **"

echo "Setting environment variables"
source set_container_envars.sh

pushd sys_scripts > /dev/null
  ./apt_system_upgrade.sh
  ./apt_linux_dependencies.sh
  ./terminal_setup.sh
  ./zephyr_cli.sh
  ./build_tests.sh
  ./apt_pkg_db_updates.sh
popd > /dev/null

echo "** System Setup Finished **"
