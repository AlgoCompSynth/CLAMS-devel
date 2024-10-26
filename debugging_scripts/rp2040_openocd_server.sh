#! /bin/bash

set -e

echo "Setting $HOME/.gdbinit"
echo "target extended-remote localhost:3333" > $HOME/.gdbinit
echo "Starting openocd server"
openocd \
  --file interface/cmsis-dap.cfg \
  --file target/rp2040.cfg \
  --command "adapter speed 5000" \
  --log_output openocd.log &
sleep 15
ps -ef | grep openocd
