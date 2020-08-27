
#!/bin/sh

OUR_SERVER_ADDRESS=$(ip addr show eht0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")


consul connect -http-addr "${OUR_SERVER_ADDRESS}:8500" -grpc-addr ${OUR_SERVER_ADDRESS}:8502" envoy -sidecar-for activites-1