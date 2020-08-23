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

  // check {
  //   id       = "counting-check"
  //   http     = "http://localhost:9003/health"
  //   method   = "GET"
  //   interval = "1s"
  //   timeout  = "1s"
  // }
}