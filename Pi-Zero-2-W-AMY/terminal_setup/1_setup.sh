#! /usr/bin/env bash

set -e

echo ""
echo "* Terminal Setup *"
source ../set_envars
export LOGFILE=$LOGFILES/terminal_setup.log
rm --force $LOGFILE

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

./apt_base.sh
./nerd_fonts.sh
./starship.sh

echo "* Finished Terminal Setup *"
