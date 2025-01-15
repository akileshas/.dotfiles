#!/bin/bash
# Display current GPU usage and memory usage for NVIDIA

# Get GPU usage percentage
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# Get total and used memory in MiB
gpu_memory_info=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits)
used_memory=$(echo $gpu_memory_info | cut -d ',' -f 1)
total_memory=$(echo $gpu_memory_info | cut -d ',' -f 2)

# Display GPU usage and memory usage
echo "   ${gpu_usage}% - ${used_memory} MiB "
