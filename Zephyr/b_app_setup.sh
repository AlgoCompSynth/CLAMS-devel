#! /usr/bin/env bash

set -e

echo ""
echo "** Applications **"

echo ""
echo "Setting environment variables"
source set_container_envars.sh

echo "Clearing logfiles"
rm --force --recursive app_scripts/Logs

pushd app_scripts > /dev/null
popd > /dev/null

pushd sys_scripts > /dev/null
  ./apt_pkg_db_updates.sh
popd > /dev/null

echo ""
echo "** Applications Finished **"
