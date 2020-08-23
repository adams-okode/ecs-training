#lol
FROM consul:latest
COPY consul.hcl /etc/consul.d/consul.hcl
CMD [ "consul", "agent", "-config-file", "/etc/consul.d/consul.hcl" ]