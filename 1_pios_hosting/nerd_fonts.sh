#! /usr/bin/env bash

set -e

echo ""
echo "** Nerd Fonts **"

mkdir --parents $HOME/.fonts
pushd $HOME/.fonts > /dev/null
  rm --force --recursive Meslo*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
    unzip -qq ../Meslo.zip
    mv *.ttf ../
  cd ..
  rm --force --recursive Meslo Meslo.zip
popd > /dev/null

echo "** Finished Nerd Fonts **"
