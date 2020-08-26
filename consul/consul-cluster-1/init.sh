#!/bin/sh

# Set variables
OUR_SERVER_ADDRESS=$(ip addr show eth0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

export CONSUL_GRPC_ADDR="{$OUR_SERVER_ADDRESS}:8502"

export CONSUL_GRPC_ADDR="{$OUR_SERVER_ADDRESS}:8500"

echo '1'
echo $OUR_SERVER_ADDRESS
# Collect sample json file
SAMPLE_FILE=$(cat ./opt/consul/consul.sample.json)

echo '2'
echo $SAMPLE_FILE

# Read in template one line at the time, and replace variables (more natural (and efficient) way, thanks to Jonathan Leffler).
JSON_STRING=$(jq -n --arg snadress "$OUR_SERVER_ADDRESS" "$SAMPLE_FILE")

echo $JSON_STRING >>/etc/consul.d/consul.json

echo '2'
echo $JSON_STRING

echo $(ip addr show eth0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

# Initialize the consul agent
envoy -c /etc/envoy/envoy.yaml

consul agent -config-file /etc/consul.d/consul.json
