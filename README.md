# VM Testing Scripts

This folder contains chaos and load testing scripts for a VM-hosted application.

## Chaos Scripts
- **cpu_stress.sh**: Simulates CPU saturation
- **memory_stress.sh**: Simulates memory pressure
- **disk_stress.sh**: Simulates disk I/O saturation
- **network_latency.sh**: Adds network latency and packet loss
- **kill_app.sh**: Terminates the application process

## Load Scripts
- **locustfile.py**: Python-based load testing with Locust
- **k6_spike_test.js**: JavaScript-based spike load testing with k6

## Usage
1. Make scripts executable:
   ```bash
   chmod +x chaos/*.sh
   ```
Run chaos scripts in staging or off-peak hours.

Replace <VM_IP_OR_DOMAIN> in load scripts with your VM's address.

Run Locust or k6 as shown in individual scripts.

Run Locust:
```bash
locust -f locustfile.py
```
Run k6:
```bash
k6 run load/k6_spike_test.js
```
---

