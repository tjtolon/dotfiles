source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen theme robbyrussell
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle common-aliases
antigen bundle cp
antigen bundle command-not-found
antigen bundle colored-man-pages
antigen apply

if [ -f /opt/ros/melodic/setup.zsh ]; then
    source /opt/ros/melodic/setup.zsh
    export ROS_PACKAGE_PATH=/home/tatu/ladimo/ros:$ROS_PACKAGE_PATH
fi
