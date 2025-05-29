# Building the Linux-Tools container

1. On the host, run `./1_host_linux_tools`. This builds
the Linux-Tools container.

2. On the host, type `distrobox enter Linux-Tools`.
Then type `./2_dbx_terminal_setup.sh`. This will
download the "Meslo" nerd font, install the `starship`
command prompt tool, create a few directories and then
update all the package databases.

3. Still in the container, type `./3_dbx_install_all.sh`.
This will install the Linux versions of CircuitPython
and MicroPython, plus six different Linux Forth packages.
