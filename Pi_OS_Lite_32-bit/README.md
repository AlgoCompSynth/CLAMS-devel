# Usage notes

1. `git` is not installed by default on PiOS Lite 32-bit. So you
will need to do

    ```
    sudo apt update && sudo apt install -y git
    ```

    first.

2. Once you have `git` installed, do

    ```
    git clone https://github.com/AlgoCompSynth/CLAMS-devel.git
    cd CLAMS-devel/Pi_OS_Lite_32-bit
    ./0_setup.sh 2>&1 | tee 0_setup.log
    ```

3. Reboot

4. After the reboot, install the optional command line conveniences:

    ```
    ./1_command_line_setup.sh
    ```

    You can also install optional tools in the `Apps` directory.
