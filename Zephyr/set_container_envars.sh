export COMPUTE_MODE=CPU
#export COMPUTE_MODE=CUDA
export DBX_CONTAINER_NAME="Zephyr-Devel-$COMPUTE_MODE"
export DBX_CONTAINER_IMAGE="quay.io/toolbx/ubuntu-toolbox:24.04"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes"
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"

export ARCH=`uname -m`
echo "ARCH: $ARCH"

## Zephyr OS
export ZEPHYR_OS_PROJECT="$HOME/zephyr_os_project"
export ZEPHYR_OS_VENV="$ZEPHYR_OS_PROJECT/.venv"
