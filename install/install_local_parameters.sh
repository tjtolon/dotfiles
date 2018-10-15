#!/bin/bash

local_parameters=(
    "TATU_SETUP_POLYBAR_BAR" \
    "TATU_SETUP_WIFI_INTERFACE" \
    "TATU_SETUP_ETHERNET_INTERFACE" \
    "TATU_SETUP_KEEPASS_DB")
declare -A descriptions=(
    ["TATU_SETUP_POLYBAR_BAR"]="Polybar profiili: laptop, desktop"
    ["TATU_SETUP_WIFI_INTERFACE"]="Wifi rajapinta"
    ["TATU_SETUP_ETHERNET_INTERFACE"]="Ethernet rajapinta"
    ["TATU_SETUP_KEEPASS_DB"]="Keepass tietokannan ssh-polku"
)
BASEDIR=$(dirname "$0")


function check_for_local_parameter() {
    param_to_check=$1
    if ! ag $param_to_check $BASEDIR/profile >> /dev/null; then
        echo "${descriptions[${param_to_check}]}"
        read value
        echo "export ${param}=${value}" >> $BASEDIR/profile
    fi
}

if [[ ! -f $BASEDIR/profile ]]; then
    echo "#!/bin/bash" >> $BASEDIR/profile
fi

for param in "${local_parameters[@]}"; do
    check_for_local_parameter $param
done
