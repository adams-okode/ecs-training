#lol
FROM consul:latest
COPY consul.hcl /etc/consul.d/consul.hcl
CMD [ "consul", "agent", "-config_file", "/etc/consul.d/consul.hcl" ]