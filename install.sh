#!/bin/bash

BASEDIR=$(dirname "$0")
./"$BASEDIR"/install/install_apt.sh
./"$BASEDIR"/install/install_zsh_antigen.sh
./"$BASEDIR"/install/install_polybar.sh
./"$BASEDIR"/install/install_emacs.sh
./"$BASEDIR"/install/install_local_parameters.sh
./"$BASEDIR"/install/install_telegram.sh
