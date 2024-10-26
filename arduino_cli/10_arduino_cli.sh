#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
export LOGFILE=$PWD/10_arduino_cli.log
rm -f $LOGFILE

echo "Installing locally via 'curl'"
# https://arduino.github.io/arduino-cli/0.20/installation/
/usr/bin/time --output=$LOGFILE --append \
  curl -fsSL $ARDUINO_CLI_URL | BINDIR=$ARDUINO_CLI_PATH sh \
  >> $LOGFILE 2>&1
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
