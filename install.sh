#!/bin/bash

mkdir ~/.antigen
curl -L git.io/antigen > ~/.antigen/antigen.zsh

# Asenna nerd fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "SauceCodePro Nerd Font.ttf"\
 https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
fc-cache -f


# Kloonaa polybar
git clone --recursive https://github.com/jaagr/polybar ~/polybar
mkdir ~/polybar/build/

cd ~/polybar/build
cmake ..
sudo make install


chsh -s /bin/zsh

git clone --depth 1 -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d