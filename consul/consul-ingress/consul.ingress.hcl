Kind = "ingress-gateway"
Name = "ingress-service"

// TLS {
//  Enabled = true
// }

Listeners = [
  {
    Port     = 8080
    Protocol = "http"
    Services = [
      {
        Name = "*"
      }
    ]
  },
  {
    Port     = 8080
    Protocol = "tcp"
    Services = [
      {
        Name = "*"
      }
    ]
  },
 
]