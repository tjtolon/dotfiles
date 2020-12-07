. ~/dotfiles/profile
export PATH=~/dotfiles/scripts:$PATH
export PATH=~/dotfiles/bin:$PATH
export PATH=~/work-scripts:$PATH
export PATH="/home/tatu/anaconda3/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Haskell cabal
export PATH="/opt/ghc/8.4.3/bin:$PATH"
export PATH="/opt/cabal/2.2/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

export PATH=$PATH:$HOME"/pycharm-current/bin"
export PATH=$PATH:$HOME"/clion-current/bin"
export PATH=$HOME"/clion-current/bin/cmake/linux/bin":$PATH
export PATH=$PATH:$HOME"/.Nozbe"
export PATH=$PATH:$HOME"/Telegram"

export PATH=$PATH:$HOME"/intelFPGA/quartus/bin"
export PATH=$PATH:$HOME"/intelFPGA/quartus/sopc_builder/bin"
export PATH=$PATH:$HOME"/intelFPGA/embedded/host_tools/altera/device_tree"
export PATH=$PATH:$HOME"/intelFPGA/embedded/host_tools/altera/preloadergen"
export PATH=$PATH:$HOME"/intelFPGA/modelsim_ase/linuxaloem"
export QSYS_ROOTDIR=$HOME"/intelFPGA/quartus/sopc_builder/bin"
export SOCEDS_DEST_ROOT=$HOME"/intelFPGA/embedded"

export PATH=$PATH:$HOME"/go/bin"
export PATH=$PATH:$HOME"/mcu/sam-ba_cdc_linux"
export PATH=$HOME"/mcu/gcc-arm-none-eabi-7-2018-q2-update/bin":$PATH

# Vulkan and CUDA and all that
export VULKAN_SDK=$HOME"/VulkanSDK/current/x86_64"
export PATH=$PATH:$VULKAN_SDK"/bin"
export VK_LAYER_PATH=$VULKAN_SDK"/etc/explicit_layer.d"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VULKAN_SDK"/lib"
export PATH=$PATH:/usr/local/cuda/bin

export AWT_TOOLKIT=MToolkit
export TERMINAL=gnome-terminal

. /home/tatu/ladimo/core/setup_env.sh
export PATH=$PATH:$LADIMO_ROOT/build-release/apps/ladimo-client
export PATH=$PATH:$LADIMO_ROOT/build-release/apps/ladimo-server
export PATH=$PATH:$LADIMO_ROOT/build-release/apps/ladimo-calibrator
export PATH=$PATH:$LADIMO_ROOT/build-release/apps/ladimo-simulator
export PATH=$PATH:$LADIMO_ROOT/build-release/apps/imshow
export LADIMO_CLIENT_DATA_DIR=/home/tatu/ladimo/core/data-dirs/ladimo-client/
export LADIMO_SERVER_DATA_DIR=/home/tatu/ladimo/core/data-dirs/ladimo-server/
export LADIMO_SIMULATOR_DATA_DIR=/home/tatu/ladimo/core/data-dirs/ladimo-simulator/
export LADIMO_CALIBRATOR_DATA_DIR=/home/tatu/ladimo/core/data-dirs/ladimo-calibrator/

export EDITOR=nano

export JAVA_HOME=$HOME/jdk-12.0.1
export JDK_HOME=$HOME/jdk-12.0.1
export PATH=$JAVA_HOME/bin:$PATH
