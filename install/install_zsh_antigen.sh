#!/bin/bash
sudo apt install -y curl zsh

if [[ ! -f ~/.antigen/antigen.zsh ]] ; then
    mkdir ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
else
    echo "Antigen has already been installed"
fi

if [[ $0 != "zsh" ]] ; then
    chsh -s /bin/zsh
else
    echo "Zsh has already been set up to be the shell of choice"
fi
