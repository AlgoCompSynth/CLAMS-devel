#! /bin/bash

set -e

find $HOME -name '*.uf2' 2> /dev/null | sort | tee uf2Files.log

echo "Finished"
