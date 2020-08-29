#!/bin/sh
SERVICE="activities"

OUR_SERVER_ADDRESS=$(ip addr show eth0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

# Collect sample json file remove auto
SAMPLE_FILE=$(cat ./opt/consul/configs/config.mapper.json)

# Read in template one line at the time, and replace variables (more natural (and efficient) way, thanks to Jonathan Leffler).
JSON_STRING=$(jq -n --arg service "$SERVICE" "$SAMPLE_FILE")

echo $JSON_STRING >> /opt/consul/configs/service_"$SERVICE"_consul.json

consul config write -http-addr="$OUR_SERVER_ADDRESS:8500" /opt/consul/configs/service_"$SERVICE"_consul.json

consul connect envoy -http-addr="$OUR_SERVER_ADDRESS:8500" -grpc-addr="$OUR_SERVER_ADDRESS:8502" -sidecar-for "$SERVICE"-1


