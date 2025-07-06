export COMPUTE_MODE=CPU
#export COMPUTE_MODE=CUDA

export DBX_CONTAINER_NAME="Zephyr-Devel-$COMPUTE_MODE"
export DBX_CONTAINER_IMAGE="quay.io/toolbx/ubuntu-toolbox:24.04"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes" # inside the host
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME" # inside the host

export ARCH=`uname -m`

## Zephyr OS
export ZEPHYR_PROJECT="$HOME/zephyrproject" # inside the container
export ZEPHYR_WORKSPACE="$ZEPHYR_PROJECT/zephyr" # inside the container
export ZEPHYR_VENV="$ZEPHYR_PROJECT/.venv" # inside the container

export ZEPHYR_SDK_BASE="zephyr-sdk-0.17.2"
export ZEPHYR_SDK_PATH="$HOME/$ZEPHYR_SDK_BASE" # inside the container
export HOST_ZEPHYR_SDK_PATH="$DBX_CONTAINER_DIRECTORY/$ZEPHYR_SDK_BASE" # inside the host
export ZEPHYR_OPENOCD_NAME="60-openocd.rules"
export ZEPHYR_OPENOCD_LOC="sysroots/x86_64-pokysdk-linux/usr/share/openocd/contrib"
export ZEPHYR_OPENOCD_SRC="$HOST_ZEPHYR_SDK_PATH/$ZEPHYR_OPENOCD_LOC/$ZEPHYR_OPENOCD_NAME" # inside the host
export HOST_OPENOCD_DEST="/etc/udev/rules.d/$ZEPHYR_OPENOCD_NAME" # inside the host
