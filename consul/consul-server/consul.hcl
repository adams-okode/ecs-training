datacenter = "our_dc"
data_dir = "/opt/consul"
// verify_incoming = true
// verify_outgoing = true
// verify_server_hostname = true
// grpc //server
bootstrap_expect = 1
ui = true
client_addr = "0.0.0.0"
server = true
ports {
  grpc = 8502
}
connect {
  enabled = true
}
bind_addr = "{{GetInterfaceIP \"eth0\"}}"

// auto_encrypt = {
//   allow_tls = true
// }

// acl = {
//   enabled = true
//   default_policy = "deny"
//   enable_token_persistence = true
// }
 
//lol lol
