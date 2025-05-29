# Building the Pico-SDK container

1. On the host, run `./1_host_pico_sdk`. This builds
the Pico-SDK container.

2. On the host, type `distrobox enter Pico-SDK`.
Then type `./2_dbx_terminal_setup.sh`. This will
download the "Meslo" nerd font, install the `starship`
command prompt tool, create a few directories and then
update all the package databases.

3. Still in the container, type `./3_dbx_install_all.sh`.
This will install all of the Pico and TinyVision `pico-ice`
tools.
