#!/bin/bash

wget https://telegram.org/dl/desktop/linux || exit 1
tar -xvf linux
mv Telegram ~
rm -fr linux
