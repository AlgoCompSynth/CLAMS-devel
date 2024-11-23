#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/10_arduino_ide.log
rm --force $LOGFILE

echo "Installing IDE via 'curl'"
mkdir --parents $ARDUINO_IDE_PATH
pushd $ARDUINO_IDE_PATH/..
  rm -fr arduino*
  curl -sOL $ARDUINO_IDE_URL
  unzip $ARDUINO_IDE_ZIPFILE
  rm -f $ARDUINO_IDE_ZIPFILE
popd

echo "Copying 'arduino-ide' and 'test_usb_serial_output.sh' to $HOME/.local/bin/"
cp arduino-ide test_usb_serial_output.sh $HOME/.local/bin/

# https://arduino.github.io/arduino-cli/0.20/installation/
echo "Copying $ARDUINO_CLI_EXECUTABLE to $HOME/.local/bin"
cp $ARDUINO_CLI_EXECUTABLE $HOME/.local/bin/
arduino-cli version

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
