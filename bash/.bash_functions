#!/bin/bash

#################################################
#                BASH FUNCTIONS                 #
#################################################



# Clean the Compiled Python Files
cls_pyc() {
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
    xdg-open $* > /dev/null 2>&1
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
pwdtail ()
{
    pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}




#################################################
#                      END                      #
#################################################
