#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
./"$DIR"/install/apt_packages.py

if [[ ! -d ~/.antigen ]] ; then
    mkdir ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi


# Asenna nerd fonts
if [[ ! -f "$HOME/.local/share/fonts/SauceCodePro Nerd Font.ttf" ]] ; then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLo "SauceCodePro Nerd Font.ttf"\
                                    https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
    fc-cache -f
fi

# Kloonaa polybar
if [[ ! $(which polybar) ]] ; then
    git clone --recursive https://github.com/jaagr/polybar ~/polybar
    mkdir ~/polybar/build/
    cd ~/polybar/build || exit
    cmake ..
    sudo make install
fi

if [[ $0 != "zsh" ]] ; then
    chsh -s /bin/zsh
fi

if [[ ! -d ~/.emacs.d ]] ; then
    git clone --depth 1 -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

if [[ ! -f $DIR/profile ]] ; then
    echo "Missing Profile file, now asking questions about it and generating it"
fi

git clone --depth 1 -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

if [[ ! -f $HOME/dotfiles/profile ]] ; then
    echo "Kysytään asioita ja kirjoitetaan profiili"
    echo "Polybar profiili: laptop, desktop?"
    read polybar_value
    echo "Wifi rajapinta?"
    read wifi_interface
    echo "ethernet rajapinta?"
    read eth_interface
    echo "TATU_SETUP_POLYBAR_BAR=$polybar_value" >> $HOME/dotfiles/profile
    echo "TATU_SETUP_WIFI_INTERFACE=$wifi_interface" >> $HOME/dotfiles/profile
    echo "TATU_SETUP_ETHERNET_INTERFACE=$eth_interface" >> $HOME/dotfiles/profile
fi
