Kind = "ingress-gateway"
Name = "ingress-service"



Listeners = [
  {
    Port     = 80
    Protocol = "http"
    Services = [
      {
        Name = "*"
      }
    ]
  }
]