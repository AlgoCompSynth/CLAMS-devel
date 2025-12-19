#! /usr/bin/env bash

set -e

echo ""
echo "** Distrobox **"

mkdir --parents $HOME/Projects
pushd $HOME/Projects > /dev/null
  rm -fr distrobox
  git clone --quiet https://github.com/89luca89/distrobox.git
  cd distrobox
  sudo ./install
popd > /dev/null

echo "** Finished Distrobox **"
