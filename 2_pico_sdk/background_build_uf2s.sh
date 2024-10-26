#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "This starts up background jobs to rebuild all the example uf2s."
echo "It starts the jobs and then exits, leaving them running."
echo "You can do other stuff or just monitor their progress by doing"
echo ""
echo "    tail -f"
echo ""
echo "on the logfiles. This takes about half an hour on my 32 GB"
echo "Acer Nitro 5 laptop. It probably requires at least 8 GB of"
echo "RAM."

/usr/bin/time ./build_rp2040_examples.sh > build_rp2040_examples.log 2>&1 &
/usr/bin/time ./build_rp2350_examples.sh > build_rp2350_examples.log 2>&1 &

echo "Finished"
