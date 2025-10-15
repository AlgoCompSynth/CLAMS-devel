#! /usr/bin/env bash

set -e

mkdir --parents \
  $HOME/.config \
  $HOME/.local/bin \
  $HOME/.fonts \
  $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/1_terminal_setup.log
rm --force $LOGFILE

echo "Installing packages"
export DEBIAN_FRONTEND=noninteractie
sudo apt-get install -qqy \
  git \
  starship \
  time \
  vim \
  >> $LOGFILE 2>&1

echo "Configuring Starship"
cp starship.toml $HOME/.config/starship.toml

echo "Setting bash and vim configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing Meslo nerd fonts"
pushd $HOME/.fonts > /dev/null
  rm --force Meslo.zip
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  unzip -qqo ./Meslo.zip
  rm --force Meslo.zip
popd > /dev/null

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo ""
echo "Restart bash to get new Starship prompt"

echo "Finished"
