#!/bin/bash

# Get the uptime of the system
uptime -p | awk '{
    days=0; hours=0; minutes=0;
    for (i=1; i<=NF; i++) {
        if ($i ~ /day/) days=$(i-1);
        if ($i ~ /hour/) hours=$(i-1);
        if ($i ~ /minute/) minutes=$(i-1);
    }
    printf "%02d:%02d:%02d\n", days, hours, minutes;
}'
