datacenter = "our_dc"
data_dir = "/opt/consul"
verify_incoming = true
verify_outgoing = true



ca_file = "/opt/consul/security/consul-agent-ca.pem"
cert_file = "/opt/consul/security/our_dc-server-consul-0.pem"
key_file = "/opt/consul/security/our_dc-server-consul-0-key.pem"

encrypt = "NAqHX3HUULRuxRPSdzFAQgxpnsXxgks1VeUj4XOP1JE="
encrypt_verify_incoming = true
encrypt_verify_outgoing = true

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

auto_encrypt = {
   allow_tls = true
}

// acl = {
//   enabled = true
//   default_policy = "deny"
//   enable_token_persistence = true
// }
 
//lol lol
