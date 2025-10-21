VM Chaos + Load Testing Runbook (Command-Line Style)
Step 0: Prerequisites

Install required tools on your VM:

# Load testing
```bash
sudo apt-get update
sudo apt-get install -y hey
```

# Chaos / stress testing
```bash
sudo apt-get install -y stress-ng
```

Optional monitoring tools:

```bash
sudo apt-get install -y htop iftop sysstat
```

Step 1: Baseline Load

Determine normal system behavior before chaos:
```bash
# Send 1000 requests with 10 concurrent users
hey -n 1000 -c 10 http://localhost/
```

Observe:
```bash
# CPU and memory
htop       # interactive
top        # interactive
free -m    # memory usage

# Network
iftop      # network usage
```

Record baseline metrics:

Average response time

Max/min response time

Error rate

CPU & memory usage

Step 2: CPU Stress Test

Stress CPU gradually:

```bash
# Stress 1 CPU for 60s and brief metrics
sudo stress-ng --cpu 1 --timeout 60s --metrics-brief
```

If system stable, increase load:
```bash
sudo stress-ng --cpu 2 --timeout 60s --metrics-brief
```

Observe:

CPU usage (htop, top)

App response time (hey or browser)

Error rate in app logs

Step 3: Memory Stress Test
```bash
# Stress 1 GB memory for 60s
sudo stress-ng --vm 1 --vm-bytes 1G --timeout 60s --metrics-brief

# Increase memory if stable
sudo stress-ng --vm 2 --vm-bytes 2G --timeout 60s --metrics-brief
```

Observe:

Memory usage and swap (free -m, htop)

App errors due to OOM (Out of Memory)

Step 4: Disk I/O Stress
```bash
# Stress disk with 4 workers for 60s
sudo stress-ng --io 4 --timeout 60s --metrics-brief
```

Observe:

Disk usage & I/O wait (iostat, htop)

Response time or failed writes in the app

Step 5: Network Latency / Packet Loss
```bash
# Add 200ms delay and 10% packet loss
sudo tc qdisc add dev eth0 root netem delay 200ms loss 10%

# Wait 60 seconds to observe
sleep 60

# Remove latency
sudo tc qdisc del dev eth0 root netem
```

Observe:

App response time

Retries or errors in app logs

Step 6: Load + Chaos Combination (Optional)

While stressing CPU/memory, generate load:

```bash
# In one terminal, run CPU stress
sudo stress-ng --cpu 2 --timeout 120s --metrics-brief

# In another terminal, run load test
hey -n 5000 -c 50 http://localhost/
```

Observe:

Combined effect on latency and error rates

CPU, memory, disk, network metrics

Step 7: Cleanup / Recovery

Remove network stress if any:
```bash
sudo tc qdisc del dev eth0 root netem
```

Kill stress processes if still running:
```bash
sudo pkill stress-ng
```

Check app logs for errors and recover if needed:
```bash
# Example for systemd service
sudo systemctl restart myapp.service
```

# Notes & Tips

Start small — gradually increase stress levels.

Always monitor CPU, memory, disk, and network in parallel.

Use hey or other HTTP load tools to measure real user-facing latency.

Document all metrics — baseline vs stress — for analysis.

Run in staging or off-peak hours to avoid production impact.
