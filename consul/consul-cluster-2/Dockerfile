#lol build users
FROM consul:latest

RUN apk add jq

RUN mkdir /opt/consul

RUN mkdir /etc/consul.d

RUN chmod -R 777 /opt/consul

RUN chmod -R 777 /etc/consul.d

COPY init.sh /opt/consul/init.sh

COPY consul.sample.json /opt/consul/consul.sample.json

RUN chmod +x /opt/consul/init.sh

ENTRYPOINT [ "./opt/consul/init.sh" ]
