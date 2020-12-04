#!/usr/bin/env bash

LEVYASEMA_IP=10.88.113.3

set -e

[[ -z ${TATU_LEVYASEMA_IP} ]] && echo "TATU_LEVYASEMA_IP is unset" && exit 1
[[ -z ${TATU_LEVYASEMA_PASSWORD} ]] && echo "TATU_LEVYASEMA_PASSWORD is unset" && exit 1

echo "Installing necessary packages for mounting levyasema..."

dpkg -s cifs-utils 2>/dev/null >/dev/null || sudo apt-get -y install cifs-utils
dpkg -s avahi-utils 2>/dev/null >/dev/null || sudo apt-get -y install avahi-utils

echo "Checking if levyasema is available..."

set +e # disabling exit-on-error so we can have a working conditional

ping -c 1 levyasema.local &> /dev/null

if [[ "$?" == "0" ]]; then
  echo "Mounting levyasema..."

  set -e

  mkdir -p ~/levyasema
  sudo mount -t cifs //levyasema.local/Public/ ~/levyasema/ -o user=ladimo,uid=$(id -u),gid=$(id -g),rw,password=${TATU_LEVYASEMA_PASSWORD}

  echo -e "\nSuccess!\n"
else
  echo "Assuming VPN access, trying hardcoded IP $LEVYASEMA_IP"
  ping -c 1 $LEVYASEMA_IP &> /dev/null

  if [[ "$?" == "0" ]]; then
    echo "Mounting levyasema..."

    set -e

    mkdir -p ~/levyasema
    sudo mount -t cifs //${TATU_LEVYASEMA_IP}/Public/ ~/levyasema/ -o user=ladimo,uid=$(id -u),gid=$(id -g),rw,password=${TATU_LEVYASEMA_PASSWORD}

  else
    echo "WARNING! Levyasema was not found!"
    exit 1
  fi
fi
