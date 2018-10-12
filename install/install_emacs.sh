#!/bin/bash

if [[ ! -d ~/.emacs.d ]] ; then
    git clone --depth 1 -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
