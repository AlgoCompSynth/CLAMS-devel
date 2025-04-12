#! /usr/bin/env bash

set -e

echo "Copying ../set_pico_envars to $HOME"
cp ../set_pico_envars $HOME/

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

echo "Copying debugging scripts to $HOME/.local/bin"
cp ../debugging_scripts/* $HOME/.local/bin

echo "Installing e4thcom"
export E4THCOM_VERSION="0.8.5.2"
export E4THCOM_TARBALL="e4thcom-$E4THCOM_VERSION.tar.gz"
export E4THCOM_PATH="$HOME/.local/e4thcom-$E4THCOM_VERSION"
export E4THCOM_URL="https://wiki.forth-ev.de/lib/exe/fetch.php/projects:e4thcom:$E4THCOM_TARBALL"
mkdir --parents $E4THCOM_PATH
pushd $E4THCOM_PATH/..
  rm --force --recursive $E4THCOM_PATH
  curl -sL $E4THCOM_URL > $E4THCOM_TARBALL
  tar xf $E4THCOM_TARBALL
  rm --force $E4THCOM_TARBALL
  cp $E4THCOM_PATH/e4thcom $E4THCOM_PATH/e4thcom.i ./bin
popd

# https://starship.rs/guide/#%F0%9F%9A%80-installation
echo "Installing Starship"
export BIN_DIR=$HOME/.local/bin
curl -sS https://starship.rs/install.sh | sh
mkdir --parents $HOME/.config
cp starship.toml $HOME/.config/starship.toml

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo ""
echo "Restart bash to get new Starship prompt"

echo "Finished"
