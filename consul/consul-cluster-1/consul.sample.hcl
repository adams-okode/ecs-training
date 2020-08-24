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
        local_service_address = "${our_server_address}"
      }
    }
  }

  check {
    id       = "activities-check"
    http     = "http://${our_server_address}:8081"
    method   = "GET"
    interval = "5s"
    timeout  = "3s"
  }
}

