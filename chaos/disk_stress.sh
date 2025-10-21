#!/bin/bash
# Disk I/O stress
DURATION=${1:-60}

echo "Starting disk I/O stress for $DURATION seconds"
sudo apt-get install -y stress
stress --io 4 --timeout $DURATION
echo "Disk stress completed"
