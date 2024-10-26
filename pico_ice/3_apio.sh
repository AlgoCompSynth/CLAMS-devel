#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Creating fresh virtual environment $APIO_VENV"
rm -fr $APIO_VENV
python3 -m venv $APIO_VENV --upgrade-deps
echo "Activating virtual environment $APIO_VENV"
source $ACTIVATE_APIO_VENV
echo "Installing apio"
pip3 install --upgrade apio
echo "Installing packages"
apio install --all

echo "Listing boards, FPGAs, and examples"
apio boards --list > apio-boards.txt
apio boards --fpga > apio-fpgas.txt
apio examples --list > apio-examples.txt

echo "Deactivating virtual environment $APIO_VENV"
deactivate

# https://github.com/FPGAwars/apio/issues/377#issuecomment-2385653940
echo "Patching apio!!"
diff boards.json $APIO_VENV/lib/python3.10/site-packages/apio/resources/boards.json || true
cp boards.json $APIO_VENV/lib/python3.10/site-packages/apio/resources/boards.json || true
diff SConstruct $APIO_VENV/lib/python3.10/site-packages/apio/resources/ice40/SConstruct || true
cp SConstruct $APIO_VENV/lib/python3.10/site-packages/apio/resources/ice40/SConstruct || true

echo ""
echo "Finished"
