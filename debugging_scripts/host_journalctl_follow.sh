#! /usr/bin/env bash

set -e

journalctl --dmesg --output=short-precise --follow
