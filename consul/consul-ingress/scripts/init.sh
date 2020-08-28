#!/bin/sh
# Set variables
OUR_SERVER_ADDRESS=$(ip addr show eth0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

# Collect sample json file
SAMPLE_FILE=$(cat ./opt/consul/configs/consul.json)

# Read in template one line at the time, and replace variables (more natural (and efficient) way, thanks to Jonathan Leffler).
JSON_STRING=$(jq -n --arg snadress "$OUR_SERVER_ADDRESS" "$SAMPLE_FILE")

echo $JSON_STRING >> /etc/consul.d/consul.json

# Initialize the consul agent
# envoy -c /etc/envoy/envoy.yaml

consul agent -config-file /etc/consul.d/consul.json
