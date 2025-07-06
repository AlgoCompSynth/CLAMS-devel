#! /usr/bin/bash

source ./set_container_envars.sh
cd $ZEPHYR_WORKSPACE
source $ZEPHYR_VENV/bin/activate
exec /usr/bin/bash
