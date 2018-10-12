#!/bin/bash
if command -v franz >> /dev/null; then
    echo "command already exists"
else
    sudo apt install -y gconf2 gconf-service libappindicator1
    sudo apt install -y jq

    function parse_latest_deb_url() {
        curl_result=$(curl --silent "https://api.github.com/repos/$1/releases/latest")
        only_deb=$(echo $curl_result | jq '.assets[]|.browser_download_url'|grep ".*deb\"")
        eval "$2=$only_deb"
    }

    dl_url=''
    parse_latest_deb_url meetfranz/franz dl_url
    echo $dl_url
    wget $dl_url
    filename=${dl_url##*/}
    dpkg -i $filename
    rm $filename
fi
