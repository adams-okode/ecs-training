Kind = "ingress-gateway"
Name = "ingress-service"

// TLS {
//  Enabled = true
// reboot
// }

Listeners = [
  {
    Port     = 80
    Protocol = "http"
    Services = [
      {
        Name = "*"
      }
    ]
  },
]