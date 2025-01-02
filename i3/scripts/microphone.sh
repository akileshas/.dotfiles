#!/bin/bash

# Check if the microphone is muted using pamixer
if pamixer --default-source --get-mute | grep -q "true"; then
    echo "   "
else
    echo ""
fi
