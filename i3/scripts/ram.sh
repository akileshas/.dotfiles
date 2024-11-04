#!/bin/bash
# Display current RAM usage

# Get total and used memory in human-readable format
used_mem=$(free -h --si | awk '/^Mem:/ {print $3}')
total_mem=$(free -h --si | awk '/^Mem:/ {print $2}')

# Display RAM usage
echo "   $used_mem "
