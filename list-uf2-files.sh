#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ./set_pico_envars

find $CLAMS_BASE -name '*.uf2' | sort | tee uf2Files.log

echo "Finished"
