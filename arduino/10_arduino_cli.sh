#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/10_arduino_cli.log
rm --force $LOGFILE

echo "Installing arduino-cli via 'curl'"
mkdir --parents $ARDUINO_CLI_PATH
export BINDIR=$ARDUINO_CLI_PATH
curl -fsSL $ARDUINO_CLI_URL | sh
arduino-cli version

echo "Copying 'test_usb_serial_output.sh' to $HOME/.local/bin/"
cp test_usb_serial_output.sh $HOME/.local/bin/

echo "Creating fresh configuration file"
# https://arduino.github.io/arduino-cli/0.20/getting-started/
arduino-cli config init --overwrite \
  >> $LOGFILE 2>&1

echo "Updating index"
arduino-cli core update-index \
  >> $LOGFILE 2>&1

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
