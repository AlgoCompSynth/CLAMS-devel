#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Downloading and unpacking $MECRISP_ICE_URL"
mkdir --parents $MECRISP_ICE_PATH
pushd $MECRISP_ICE_PATH/..
curl -sL $MECRISP_ICE_URL | tar xzf -

echo "Finished"
