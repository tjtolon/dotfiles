#!/bin/bash

# Kirjoitetaan ~/.ssh/config tiedosto, ja luodaan avaimet

sudo apt install -y dialog
function insert_ssh_config() {
    tmp=tmp.tmp
    name=""
    user=""
    identityfile=""
    hostname=""
    port="22"

    dialog --ok-label "Submit" \
                    --backtitle "Linux User Management" \
                    --title "SSH Config Add" \
                    --form "Create a new ssh config" \
                    15 50 0 \
                    "Name:" 1 1 "$name" 1 15 15 0 \
                    "User:" 2 1 "$user" 2 15 15 0 \
                    "IdentityFile:" 3 1 "$identity_file" 3 15 40 0 \
                    "Hostname:" 4 1 "$hostname" 4 15 40 0 \
                    "Port:" 5 1 "$port" 5 15 6 0 \
                    > $tmp \
                    2>&1 >/dev/tty

    echo "$values"
    name=$(sed -n 1p $tmp)
    user=$(sed -n 2p $tmp)
    identityfile=$(sed -n 3p $tmp)
    hostname=$(sed -n 4p $tmp)
    port=$(sed -n 5p $tmp)

    rm $tmp

    if [[ -z $name ]] || \
           [[ -z $user ]] || \
           [[ -z $identityfile ]] || \
           [[ -z $hostname ]] || \
           [[ -z $port ]] ; then
        echo "at least one of the variables is empty"
    else
        echo "name is $name"
        echo "user is $user"
        echo "identityfile is $identityfile"
        echo "hostnameis $hostname"
        echo "port is $port"
        cat <<EOF >> ~/.ssh/config
Host $name
     User $user
     IdentityFile $identityfile
     HostName $hostname
     Port $port
EOF
    fi



}

insert_ssh_config
