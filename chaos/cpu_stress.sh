#!/bin/bash
# CPU stress test for VM
# Usage: ./cpu_stress.sh <duration_in_seconds> <cpu_cores>

DURATION=${1:-60}   # default 60s
CORES=${2:-2}       # default 2 cores

echo "Starting CPU stress: $CORES cores for $DURATION seconds"
sudo apt-get install -y stress
stress --cpu $CORES --timeout $DURATION
echo "CPU stress completed"
