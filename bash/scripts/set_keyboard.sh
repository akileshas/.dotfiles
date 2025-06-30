#!/bin/bash

# Built-in keyboard name
BUILTIN_KEYBOARD="AT Translated Set 2 keyboard"

# List of candidate external keyboards
EXTERNAL_KEYBOARDS=(
    "BY Tech Gaming Keyboard Consumer Control"
    "CX 2.4G Wireless Receiver Consumer Control"
)

# Get ID of built-in keyboard
BUILTIN_ID=$(xinput list | awk -v name="$BUILTIN_KEYBOARD" '$0 ~ name {for(i=1;i<=NF;i++) if($i ~ /id=/) {split($i, a, "="); print a[2]}}')
if [ -z "$BUILTIN_ID" ]; then
    echo "Error: Built-in keyboard '$BUILTIN_KEYBOARD' not found."
    exit 1
fi

# Check if built-in keyboard is enabled
ENABLED_STATUS=$(xinput list-props "$BUILTIN_ID" | grep "Device Enabled" | awk '{print $4}')

if [ "$ENABLED_STATUS" = "0" ]; then
    echo "Built-in keyboard is currently disabled."
    read -rp "Do you want to enable it? (y/N): " RE_ENABLE
    RE_ENABLE=${RE_ENABLE,,}  # lowercase
    if [ "$RE_ENABLE" = "y" ]; then
        echo "Enabling built-in keyboard..."
        xinput enable "$BUILTIN_ID"
    else
        echo "Built-in keyboard remains disabled."
    fi
    exit 0
fi

# Track whether to disable the built-in keyboard
DISABLE_BUILTIN="false"

# Check connected external keyboards and ask user if they should be considered
for KEYBOARD in "${EXTERNAL_KEYBOARDS[@]}"; do
    if xinput list | grep -qF "$KEYBOARD"; then
        echo "Detected external keyboard: '$KEYBOARD'"
        read -rp "Do you want to consider it as an external keyboard? (y/N): " INPUT
        INPUT=${INPUT,,}
        if [ "$INPUT" = "y" ]; then
            DISABLE_BUILTIN="true"
        else
            echo "Skipped '$KEYBOARD'."
        fi
    else
        echo "Keyboard '$KEYBOARD' is not connected. Skipping."
    fi
done

# Perform action based on user choice
if [ "$DISABLE_BUILTIN" = "true" ]; then
    echo "Disabling built-in keyboard (ID: $BUILTIN_ID)..."
    xinput disable "$BUILTIN_ID"
else
    echo "No external keyboard selected and connected. Built-in keyboard remains enabled."
fi
