#! /bin/bash

set -e

echo "This script must be run in host!!!"
export DELAY=5
for GROUP in ACM USB
do
  export DEVICE="/dev/tty$GROUP*"
  echo "Choosing device $DEVICE"
  ls -al $DEVICE || true
  echo "Executing 'sudo chmod a+rw $DEVICE || true' in $DELAY seconds!"
  sleep $DELAY
  sudo chmod a+rw $DEVICE || true
  ls -al $DEVICE || true
done
