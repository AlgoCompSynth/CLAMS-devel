# Building the base container

1. On the host system, run `./1_host_udev_rules.sh`. This
sets `udev` rules for all the devices I know about. Note
that because groups and permissions vary among the host,
container and software, devices must usually be given
world read and write permission! Yes, this can be a
security issue - consider this your warning.

2. On the host, run `./2_host_clams_dev_base`. This builds
the base container; all others start from a clone of
this one. It takes quite a bit of time for this to
install all the packages. On my Acer Nitro 5 and a
300 mbit / second download link it takes about 15
minutes.

3. On the host, type `distrobox enter CLAMS-dev-base`.
Then type `./3_dbx_terminal_setup.sh`. This will
download the "Meslo" nerd font, install the `starship`
command prompt tool, create a few directories and then
update all the package databases.
