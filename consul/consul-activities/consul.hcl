datacenter = "our_dc"
data_dir = "/opt/consul"
// verify_incoming = true
// verify_outgoing = true
// verify_server_hostname = true
bootstrap_expect = 1
ui = true
client_addr = "0.0.0.0"
server = true
connect = {
  enabled = true
}
bind_addr = "{{ GetInterfaceIP "eth0" }}"
 

service {
  name = "counting"
  id = "counting-1"
  port = 9003

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