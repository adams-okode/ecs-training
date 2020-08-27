
#!/bin/sh

OUR_SERVER_ADDRESS=$(ip addr show eth0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")


consul connect envoy -http-addr="$OUR_SERVER_ADDRESS:8500" -grpc-addr="$OUR_SERVER_ADDRESS:8502" -sidecar-for activites-1


