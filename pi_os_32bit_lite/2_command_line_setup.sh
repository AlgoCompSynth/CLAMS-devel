#! /usr/bin/env bash

set -e

echo "Creating home directories"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin
mkdir --parents $HOME/Logfiles
mkdir --parents $HOME/Projects

echo "Setting base configuration files"
cp bashrc $HOME/.bashrc; source bashrc
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Configuring git user details"
git config --global user.email "znmeb@znmeb.net"
git config --global user.name "M. Edward (Ed) Borasky"

echo "Installing Meslo nerd fonts"
pushd /tmp

  echo "Downloading patched MesloLG Nerd fonts"
  rm --force --recursive Meslo*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
  unzip ../Meslo.zip

  echo "Copying to $HOME/.fonts"
  mkdir --parents $HOME/.fonts
  cp *.ttf $HOME/.fonts

  popd

# https://starship.rs/guide/#%F0%9F%9A%80-installation
echo "Installing Starship"
export BIN_DIR=$HOME/.local/bin
curl -sS https://starship.rs/install.sh | sh
echo "Configuring Starship"
mkdir --parents $HOME/.config
cp starship.toml $HOME/.config/starship.toml

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo "Running system upgrades"
./upgrade_system.sh

echo ""
echo "Restart bash to get new Starship prompt"

echo "Finished"
