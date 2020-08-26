#!/bin/sh

SERVER_IP=$(ip addr show eth0 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

echo "CONSUL_HTTP_ADDR=$SERVER_IP:8500" >> /proc/1/environ