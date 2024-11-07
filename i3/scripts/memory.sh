#!/bin/bash
# Display current RAM and Swap usage in GiB with one decimal precision

# Get total and used memory in bytes and convert to GiB
used_mem=$(free -b | awk '/^Mem:/ {printf "%.1f", $3/1024/1024/1024}')
total_mem=$(free -b | awk '/^Mem:/ {printf "%.1f", $2/1024/1024/1024}')

# Get total and used swap memory in bytes and convert to GiB
used_swap=$(free -b | awk '/^Swap:/ {printf "%.1f", $3/1024/1024/1024}')
total_swap=$(free -b | awk '/^Swap:/ {printf "%.1f", $2/1024/1024/1024}')

# Display RAM and Swap usage with decorative separators and GiB label
echo "   RAM: ${used_mem}/${total_mem} GiB • SWAP: ${used_swap}/${total_swap} GiB "
