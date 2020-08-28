#!/bin/sh

OUR_SERVER_ADDRESS=$(ip addr show eth0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

consul config write -http-addr="$OUR_SERVER_ADDRESS:8500" ./opt/consul/consul.ingress.hcl

consul connect envoy -http-addr="$OUR_SERVER_ADDRESS:8500" -grpc-addr="$OUR_SERVER_ADDRESS:8502" -gateway=ingress -register -service ingress-service -address '{{ GetInterfaceIP "eth0" }}:8888'
