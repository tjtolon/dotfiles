#!/bin/bash
susdo apt install -y curl zsh

if [[ ! -f ~/.antigen/antigen.zsh ]] ; then
    mkdir ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

if [[ $0 != "zsh" ]] ; then
    chsh -s /bin/zsh
fi
