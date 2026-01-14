#! /usr/bin/env bash

set -e

echo ""
echo "*** Nerd Fonts ***"

mkdir --parents $HOME/.fonts
pushd $HOME/.fonts > /dev/null
  rm --force --recursive FiraCode*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
  unzip -qqo FiraCode.zip
popd > /dev/null

echo "*** Finished Nerd Fonts ***"
