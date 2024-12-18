#!/bin/bash

#################################################
#                BASH FUNCTIONS                 #
#################################################



# Clean the Compiled Python Files
cls-pyc() {
    # Remove all .pyc files recursively
    find . -name '*.pyc' -delete
}

# Creates a directory (if it doesn't exist) and changes into it
mcd() {
    # If a directory name is provided, create the directory and move into it
    [[ "$1" ]] && mkdir -p "$1" && cd "$1"
}

# Reset the git repository
nah() {
    git reset --hard

    if [[ $1 == "-f" ]]; then
        git clean -df
    fi
}

# Open the default program for the file
open() {
    xdg-open $* >/dev/null 2>&1
}

# Network Information
netinfo() {
    echo "--------------- Network Information ---------------"

    # Display network interfaces (excluding loopback)
    for iface in $(ip -o link show | awk -F': ' '{print $2}' | grep -v 'lo'); do
        echo "Interface: $iface"

        # Get the IPv4 address
        ipv4=$(ip -o -4 addr show dev $iface | awk '{print $4}')
        echo "IP Address (IPv4): $ipv4"

        # Get the IPv6 address
        ipv6=$(ip -o -6 addr show dev $iface | awk '{print $4}')
        echo "IP Address (IPv6): $ipv6"

        # Get the netmask (CIDR)
        netmask=$(ip -o -4 addr show dev $iface | awk '{print $4}' | cut -d/ -f2)
        echo "Netmask (IPv4): $netmask"

        # Get the broadcast address
        broadcast=$(ip -o addr show dev $iface | awk '/broadcast/ {print $4}')
        echo "Broadcast Address: $broadcast"

        # Get the MAC address
        mac=$(ip link show dev $iface | awk '/ether/ {print $2}')
        echo "MAC Address: $mac"

        # Get the default gateway
        gateway=$(ip route show dev $iface default | awk '/default/ {print $3}')
        echo "Default Gateway: $gateway"

        echo "---------------------------------------------------"
    done
}

# Returns the last 2 fields of the working directory
pwdtail() {
    pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
    local d=""
    limit=$1
    for ((i = 1; i <= limit; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# Copy file with a progress bar
cpb() {
    set -e
    total_size=$(stat -c '%s' "${1}")
    dd if="${1}" of="${2}" bs=4K status=none 2>&1 |
        awk -v total_size="$total_size" '{
        count += 4096
        if (count > total_size) count = total_size
        percent = int(count / total_size * 100)
        printf "\r%3d%% [", percent
        for (i = 0; i < percent; i++) printf "="
        printf ">"
        for (i = percent; i < 100; i++) printf " "
        printf "]"
        fflush()
    }
    END { print "" }'
}

# cd to the back directory
# bd() {
#     local backdir=$OLDPWD
#     cd $backdir
# }

# reading the hexa value of a file
hexaread() {
    hexdump -C "$1" | nvim
}



#################################################
#                      END                      #
#################################################
