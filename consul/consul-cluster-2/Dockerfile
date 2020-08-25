#lol build users

FROM consul:latest

FROM envoyproxy/envoy:v1.14.4

RUN apk update && apk add jq --no-cache supervisor

RUN mkdir /opt/consul && chmod -R 777 /opt/consul

RUN mkdir /etc/consul.d && chmod -R 777 /etc/consul.d

RUN mkdir /var/logs && chmod -R 777 /var/logs

COPY init.sh /opt/consul/init.sh

COPY consul.sample.json /opt/consul/consul.sample.json

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /opt/consul/init.sh

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]

