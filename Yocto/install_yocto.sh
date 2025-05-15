#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_yocto.log
rm --force $LOGFILE

export NEW_CONFIG_FILE=$PWD/local.conf

mkdir --parents $POKY_PATH
pushd $POKY_PATH/..
  echo "Cloning poky"
  rm -fr $POKY_PATH
  /usr/bin/time git clone $POKY_URL \
    >> $LOGFILE 2>&1
popd

pushd $POKY_PATH
  echo "Initializing repository"
  git checkout -t origin/${POKY_VERSION} -b my-${POKY_VERSION}
  source oe-init-build-env
popd

echo "Enabling upstream artifact servers"
diff $NEW_CONFIG_FILE $POKY_CONFIG_FILE || true
cp $NEW_CONFIG_FILE $POKY_CONFIG_FILE

echo "Finished"
