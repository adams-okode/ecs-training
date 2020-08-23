#lol
FROM consul:latest
ADD consul.hcl /etc/consul.d/consul.hcl
CMD [ "consul", "agent", "-config_file=/etc/consul.d/consul.hcl" ]