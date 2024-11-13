#!/bin/bash

# Enable strict error handling:
# -e: Exit immediately if any command returns a non-zero status.
# -u: Treat unset variables as an error.
# -o pipefail: Causes a pipeline to fail if any command fails (non-zero status).
set -euo pipefail

# Thresholds for CPU and Memory usage percentages.
# If usage exceeds these thresholds, a warning will be printed.
CPU_THRESHOLD=80
MEM_THRESHOLD=80

# Function to get current CPU usage as a percentage.
# It extracts the usage from the 'top' command output by summing the idle and user percentages.
get_cpu_usage(){
    top -bn1 | grep "Cpu(s)" | awk '{print $2+$4}'
}

# Infinite loop to continuously monitor system metrics.
while true; do
    # Get total and used memory in megabytes (MB).
    # The 'free' command is used to capture memory stats, and 'awk' extracts the relevant values.
    total_mem=$(free -m | awk '/Mem:/ {print $2}')
    used_mem=$(free -m | awk '/Mem:/ {print $3}')

    # Calculate memory usage as a percentage.
    # Integer division is used to calculate the memory usage percentage.
    mem_usage=$(( 100 * used_mem / total_mem ))

    # Get the current CPU usage by calling the get_cpu_usage function.
    CPU_USAGE=$(get_cpu_usage)

    # Check if CPU usage exceeds the defined CPU_THRESHOLD.
    # If the CPU usage percentage is above the threshold, print a warning message.
    # Otherwise, indicate that CPU usage is within acceptable limits.
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "Warning: CPU usage is at ${CPU_USAGE}%! Exceeds ${CPU_THRESHOLD}% threshold. Turn off engine."
    else
        echo "CPU usage is at ${CPU_USAGE}% - within acceptable limits."
    fi

    # Check if memory usage exceeds the defined MEM_THRESHOLD.
    # If the memory usage percentage is above the threshold, print a warning message.
    # Otherwise, indicate that memory usage is within acceptable limits.
    if (( mem_usage > MEM_THRESHOLD )); then
        echo "Warning: Memory usage is at ${mem_usage}%! Exceeds ${MEM_THRESHOLD}% threshold."
    else
        echo "Memory usage is at ${mem_usage}% - within acceptable limits."
    fi

    # Wait for 60 seconds before running the checks again to avoid overloading the system.
    sleep 60
done
