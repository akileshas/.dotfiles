#!/bin/bash

# Get the uptime of the system
uptime | sed -n 's/.*up \([^,]*\),.*/\1/p'
