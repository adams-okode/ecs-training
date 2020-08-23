#lol
FROM consul:latest
COPY consul.hcl /etc/consul.d/consul.hcl
RUN mkdir /opt/consul
RUN chmod -R 777 /opt/consul
CMD [ "consul", "agent", "-config-file", "/etc/consul.d/consul.hcl" ]