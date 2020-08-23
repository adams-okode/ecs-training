datacenter = "our_dc"
data_dir = "/ecs-builder/consul"
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
