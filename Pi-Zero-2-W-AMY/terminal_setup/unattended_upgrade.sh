#! /usr/bin/env bash

set -e

echo ""
echo "*** Unattended Upgrade ***"

export DEBIAN_FRONTEND=noninteractive
echo "Update"
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
echo "Upgrade"
# https://debian-handbook.info/browse/stable/sect.automatic-upgrades.html
yes '' \
  | sudo apt-get -qqy \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  dist-upgrade \
  >> $LOGFILE 2>&1
echo "Autoremove"
sudo apt-get autoremove -qqy \
  >> $LOGFILE 2>&1

echo "*** Finished Unattended Upgrade ***"
