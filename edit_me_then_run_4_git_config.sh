#! /bin/bash

echo "Edit before running!"
echo "Sleeping 15 seconds."
sleep 15
git config --global user.email ""
git config --global user.name ""
git config --global advice.detached false
git config --global pull.rebase false
git config --global push.default simple
