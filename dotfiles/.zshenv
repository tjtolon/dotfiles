. ~/dotfiles/profile
export PATH=~/dotfiles/scripts:$PATH
export PATH=~/dotfiles/bin/:$PATH
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

export VULKAN_SDK=$HOME"/VulkanSDK/current/x86_64"
export PATH=$PATH:$VULKAN_SDK"/bin"
export VK_LAYER_PATH=$VULKAN_SDK"/etc/explicit_layer.d"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VULKAN_SDK"/lib"

export AWT_TOOLKIT=MToolkit
export TERMINAL=gnome-terminal
export LADIMO=/home/tatu/ladimo/ladimo-core/test_data/set_01/
export LADIMO_ROOT=/home/tatu/ladimo/ladimo-core
export PATH=$PATH:$LADIMO_ROOT/build-release/apps/ladimo-client

export EDITOR=nano

export JAVA_HOME=$HOME/jdk-12.0.1
export JDK_HOME=$HOME/jdk-12.0.1
export PATH=$JAVA_HOME/bin:$PATH
