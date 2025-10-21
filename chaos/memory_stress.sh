#!/bin/bash
# Memory stress test
# Usage: ./memory_stress.sh <memory_in_MB> <duration_in_seconds>

MEMORY=${1:-1024}  # default 1GB
DURATION=${2:-60}  # default 60s

echo "Starting memory stress: $MEMORY MB for $DURATION seconds"
sudo apt-get install -y stress
stress --vm 1 --vm-bytes ${MEMORY}M --timeout $DURATION
echo "Memory stress completed"
