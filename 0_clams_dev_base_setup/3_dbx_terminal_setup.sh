#! /usr/bin/env bash

set -e

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin

echo "Setting base configuration files"
cp bashrc $HOME/.bashrc; source bashrc
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

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

echo "Installing Starship"
./install_starship.sh
mkdir --parents $HOME/.config
cp starship.toml $HOME/.config/starship.toml

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/pkg_db_updates.log
rm --force $LOGFILE

echo "Upgrading packages"
sudo apt-get update \
  >> $LOGFILE 2>&1
sudo apt-get upgrade --assume-yes \
  >> $LOGFILE 2>&1

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "Updating manual database"
sudo mandb \
  >> $LOGFILE 2>&1

echo ""
echo "Restart bash to get new Starship prompt"

echo "Finished"
