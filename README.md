# CPU and Memory Usage Monitor Script

## Overview

This Bash script is designed to monitor the CPU and memory usage of your system continuously. It checks the current CPU and memory utilization every minute and alerts you if either exceeds predefined thresholds. This script is useful for system administrators or anyone who wants to keep an eye on resource usage to ensure optimal performance.

## Features

- Monitors CPU usage in real-time.
- Monitors memory usage in real-time.
- Alerts when CPU or memory usage exceeds specified thresholds.
- Configurable thresholds for CPU and memory usage.
- Runs indefinitely, checking resource usage at regular intervals.

## How It Works

1. **CPU Usage**: The script retrieves the CPU usage using the `top` command and calculates the percentage of used CPU.
2. **Memory Usage**: It uses the `free` command to get total and used memory, then calculates the memory usage percentage.
3. **Threshold Checks**: If either the CPU or memory usage exceeds the defined thresholds (default set to 80%), a warning message is displayed.
4. **Looping**: The script runs in an infinite loop, checking resource usage every 60 seconds.

## Installation

To use this script, follow these steps:

   ```bash
   git clone repo_url
   cd repo-name
   chmod +x monitor_usage.sh
   ./monitor_usage.sh
   CPU_THRESHOLD=80  # Change this value to set a different CPU threshold
   MEM_THRESHOLD=80  # Change this value to set a different Memory threshold
