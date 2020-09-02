datacenter = "our_dc"
data_dir = "/opt/consul"
// verify_incoming = true
//verify_outgoing = true



// ca_file = "consul-agent-ca.pem"
// cert_file = "our_dc-server-consul-0.pem"
// key_file = "our_dc-server-consul-0-key.pem"

// encrypt = "HljxUhiZ7ig9t5cSBDzBll35uOPEB11FSSkOd8jGUyM="
// encrypt_verify_incoming = false
// encrypt_verify_outgoing = false

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

//auto_encrypt = {
  // allow_tls = true
// }

// acl = {
//   enabled = true
//   default_policy = "deny"
//   enable_token_persistence = true
// }
 
//lol lol
