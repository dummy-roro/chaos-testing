// Run k6
// k6 run load/k6_spike_test.js

import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
  stages: [
    { duration: '1m', target: 50 },    // ramp-up
    { duration: '2m', target: 50 },    // steady load
    { duration: '1m', target: 500 },   // spike
    { duration: '2m', target: 0 },     // ramp-down
  ],
};

export default function () {
  http.get("http://<VM_IP_OR_DOMAIN>/orders");
  sleep(1);
}
