datacenter = "our_dc"

data_dir = "/opt/consul"

retry_join = ["172.31.13.201"]

bind_addr = "{{ GetInterfaceIP \"eth0\" }}"



services {
  name = "users"
  id = "users-1"
  port = 8080

  connect {
    sidecar_service {
      proxy {
        local_service_address = "${our_server_address}"
      }
    }
  }

  check {
    id       = "users-check"
    http     = "http://${our_server_address}:8080"
    method   = "GET"
    interval = "5s"
    timeout  = "3s"
  }
}


services {
  name = "activities"
  id = "activities-1"
  port = 8081

  connect {
    sidecar_service {
      proxy {
<<<<<<< HEAD:consul/consul-cluster-1/consul.sample.hcl
        local_service_address = "${our_server_address}"
=======
        local_service_address = "${var.bind_address}"
>>>>>>> 6ca09cdee135641e275decab49a58cc8e8f5bec6:consul/consul-cluster-1/consul.hcl
      }
    }
  }

  check {
    id       = "activities-check"
<<<<<<< HEAD:consul/consul-cluster-1/consul.sample.hcl
    http     = "http://${our_server_address}:8081"
=======
    http     = "http://${var.bind_address}:8081"
>>>>>>> 6ca09cdee135641e275decab49a58cc8e8f5bec6:consul/consul-cluster-1/consul.hcl
    method   = "GET"
    interval = "5s"
    timeout  = "3s"
  }
}

