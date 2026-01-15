#! /usr/bin/env bash

set -e

echo ""
echo "* c4 *"
source ../set_envars
export LOGFILE="$LOGFILES/c4.log"
rm --force $LOGFILE

echo "Cloning fresh c4 project repository"
mkdir --parents $C4_PATH
pushd $C4_PATH/..
  rm --force --recursive $C4_PATH
  /usr/bin/time git clone $C4_URL \
    >> $LOGFILE 2>&1
popd

echo "Patching makefile"
diff makefile $C4_PATH/makefile || true
cp makefile $C4_PATH/makefile

pushd $C4_PATH

  echo "Building c4"
  date +"%F %T" \
    >> $LOGFILE 2>&1
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  date +"%F %T" \
    >> $LOGFILE 2>&1

  echo "Installing c4"
  make bin

popd

echo "* Finished c4 *"
