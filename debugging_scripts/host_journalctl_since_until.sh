#! /usr/bin/env bash

set -e

journalctl --dmesg --output=short-precise --since=$1 --until=$2
