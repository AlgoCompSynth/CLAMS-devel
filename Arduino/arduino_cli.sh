#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/arduino_cli.log
rm --force $LOGFILE

echo "Installing arduino-cli from arduino-ide"
ln -sf $ARDUINO_IDE_PATH//resources/app/lib/backend/resources/arduino-cli $HOME/.local/bin
hash -r
arduino-cli version

echo "Installing bash completion file as 'root'!!"
arduino-cli completion bash > /tmp/ardunio-cli.sh
sudo mv /tmp/ardunio-cli.sh /etc/bash_completion.d/ardunio-cli.sh

echo "Installing zsh completion file if needed"
if [ -d $ZSH_LOCAL_COMPLETIONS_PATH ]
then
  arduino-cli completion zsh > /tmp/_arduino-cli.sh
  mv /tmp/_arduino-cli.sh $ZSH_LOCAL_COMPLETIONS_PATH/_arduino-cli
fi

echo "Finished"
