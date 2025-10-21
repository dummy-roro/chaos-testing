#Run Locust
#locust -f locustfile.py

from locust import HttpUser, task, between

class VMAppUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def view_orders(self):
        self.client.get("http://<VM_IP_OR_DOMAIN>/orders")

    @task
    def create_order(self):
        self.client.post("http://<VM_IP_OR_DOMAIN>/orders", json={"item": "laptop", "qty": 1})
