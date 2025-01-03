#!/bin/bash

# Check if conda is available
if command -v /home/akileshas/miniconda3/bin/conda &>/dev/null; then
    # Try to run conda shell hook for bash
    __conda_setup="$('/home/akileshas/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"

    if [ $? -eq 0 ]; then
        # If successful, evaluate the setup command
        eval "$__conda_setup"
    else
        # If not successful, source the conda initialization script
        if [ -f "/home/akileshas/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/akileshas/miniconda3/etc/profile.d/conda.sh"
        else
            # Fallback: manually update the PATH if neither method works
            export PATH="/home/akileshas/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi
