#!/bin/bash
# Display current CPU usage

# Get CPU usage percentage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Display CPU usage
echo "   ${cpu_usage}% "
