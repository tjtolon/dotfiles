export PATH="/home/tatu/anaconda3/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME"/pycharm-current/bin"
export PATH=$PATH:$HOME"/clion-current/bin"
export PATH=$PATH:$HOME"/.Nozbe"
export PATH=$PATH:$HOME"/Telegram"

export PATH=$PATH:$HOME"/intelFPGA/18.0/quartus/bin"
export PATH=$PATH:$HOME"/intelFPGA/18.0/quartus/sopc_builder/bin"
export PATH=$PATH:$HOME"/intelFPGA/18.0/embedded/host_tools/altera/device_tree"
export PATH=$PATH:$HOME"/intelFPGA/18.0/embedded/host_tools/altera/preloadergen"
export PATH=$PATH:$HOME"/intelFPGA/18.0/modelsim_ase/linuxaloem"
alias quartus="LD_LIBRARY_PATH=$HOME/intelFPGA/18.0/modelsim_ase/lib32 quartus_tatu"
export QSYS_ROOTDIR="/home/tatu/intelFPGA/18.0/quartus/sopc_builder/bin"
export SOCEDS_DEST_ROOT=$HOME"/intelFPGA/18.0/embedded"
export LM_LICENSE_FILE=$HOME"/intelFPGA/18.0/licenses/license.txt"

export VULKAN_SDK=$HOME"/VulkanSDK/current/x86_64"
export PATH=$PATH:$VULKAN_SDK"/bin"
export VK_LAYER_PATH=$VULKAN_SDK"/etc/explicit_layer.d"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VULKAN_SDK"/lib"

export AWT_TOOLKIT=MToolkit
export TERMINAL=gnome-terminal
export LADIMO=/home/tatu/ladimo/ladimo-core/test_data/set_01/
export LADIMO_ROOT=/home/tatu/ladimo/ladimo-core/
. ~/dotfiles/profile
