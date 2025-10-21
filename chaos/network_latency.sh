#!/bin/bash
# Network latency & packet loss
# Usage: ./network_latency.sh <delay_ms> <loss_percent> <duration_s>

DELAY=${1:-200}   # ms
LOSS=${2:-10}     # %
DURATION=${3:-60} # seconds

echo "Adding $DELAY ms latency and $LOSS% packet loss on eth0 for $DURATION seconds"
sudo tc qdisc add dev eth0 root netem delay ${DELAY}ms loss ${LOSS}%
sleep $DURATION
sudo tc qdisc del dev eth0 root netem
echo "Network latency test completed"
