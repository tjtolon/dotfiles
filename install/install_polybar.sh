#!/bin/bash

# Polybarin kääntäminen vaatii näitä kirjastoja
sudo apt install -y \
	   cmake \
	   cmake-data \
	   libcairo2-dev \
	   libxcb-ewmh-dev \
	   libxcb-icccm4-dev \
	   libxcb-image0-dev \
	   libxcb-randr0-dev \
	   libxcb-util0-dev \
	   libxcb-xkb-dev \
	   pkg-config \
	   python-xcbgen \
	   xcb-proto \
	   libxcb-xrm-dev \
	   libxcb-cursor-dev \
	   i3-wm \
	   libasound2-dev \
	   libmpdclient-dev \
	   libiw-dev \
	   libcurl4-openssl-dev

# Polybar käyttää SauceCodePro Nerd Font -fonttia
if [[ ! -f "$HOME/.local/share/fonts/SauceCodePro Nerd Font.ttf" ]] ; then
    mkdir -p ~/.local/share/fonts
    url=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
    cd ~/.local/share/fonts && curl -fLo "SauceCodePro Nerd Font.ttf" \
                                    $url
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
