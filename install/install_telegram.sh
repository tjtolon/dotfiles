#!/bin/bash

if [[ ! -d ~/Telegram ]] ; then
    wget https://telegram.org/dl/desktop/linux || exit 1
    tar -xvf linux
    mv Telegram ~
    rm -fr linux
else
    echo "Telegram has already been installed"

fi
