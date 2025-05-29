# Building the Pico-SDK container

1. On the host, run `./1_host_arduino`. This builds
the Arduino container.

2. On the host, type `distrobox enter Arduino`.
Then type `./2_dbx_terminal_setup.sh`. This will
download the "Meslo" nerd font, install the `starship`
command prompt tool, create a few directories and then
update all the package databases.

3. Still in the container, type `./3_dbx_install_all.sh`.
This will install the Arduino GUI and command line IDEs
and several board and library support packages.
