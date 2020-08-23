datacenter = "our_dc"
data_dir = "/opt/consul"


retry_join = ["172.31.13.201"]

service {
  name = "users"
  id = "users-1"
  port = 8080

  connect {
    sidecar_service {}
  }

  check {
    id       = "users-check"
    http     = "http://localhost:8080"
    method   = "GET"
    interval = "50s"
    timeout  = "30s"
  }
}