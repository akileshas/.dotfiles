#!/bin/bash

# Determine active network interface by checking for an IP address
# Exclude docker and loopback interfaces
INTERFACE=$(ip -o -4 addr show up | awk '{print $2}' | grep -Ev "^(docker|lo)" | head -n 1)

# Check if there is an active interface
if [ -z "$INTERFACE" ]; then
    echo "  Offline "
    exit 0
fi

# Get the IPv4 address of the active interface
IPV4_ADDRESS=$(ip -o -4 addr show "$INTERFACE" | awk '{print $4}')

# Get the IPv6 address of the active interface, if available
IPV6_ADDRESS=$(ip -o -6 addr show "$INTERFACE" | awk '{print $4}' | head -n 1)

# Get initial received and transmitted bytes
initial_rx=$(cat /sys/class/net/"$INTERFACE"/statistics/rx_bytes)
initial_tx=$(cat /sys/class/net/"$INTERFACE"/statistics/tx_bytes)

# Wait for 1 second to calculate speed
sleep 1

# Get received and transmitted bytes again
final_rx=$(cat /sys/class/net/"$INTERFACE"/statistics/rx_bytes)
final_tx=$(cat /sys/class/net/"$INTERFACE"/statistics/tx_bytes)

# Calculate bytes transferred in 1 second
rx_diff=$((final_rx - initial_rx))
tx_diff=$((final_tx - initial_tx))

# Convert bytes to megabits
rx_mbps=$(echo "scale=2; $rx_diff * 8 / 1000000" | bc)
tx_mbps=$(echo "scale=2; $tx_diff * 8 / 1000000" | bc)

# Display interface name, IP address, and network speed
if [ -n "$IPV6_ADDRESS" ]; then
    echo " ${rx_mbps}/${tx_mbps} Mbps • $INTERFACE • $IPV4_ADDRESS • $IPV6_ADDRESS "
else
    echo " ${rx_mbps}/${tx_mbps} Mbps • $INTERFACE • $IPV4_ADDRESS "
fi
