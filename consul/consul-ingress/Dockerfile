
#lol build ingress
ARG ENVOY_VERSION=1.14-latest

FROM envoyproxy/envoy-alpine:v${ENVOY_VERSION}



ARG CONSUL_VERSION=1.8.0

RUN apk update && apk add jq --no-cache supervisor 

RUN mkdir -p /opt/consul  \
    && mkdir -p /etc/consul.d \
    && mkdir /var/logs \
    && chmod -R 777 /opt/consul \
    && chmod -R 777 /etc/consul.d \
    && chmod -R 777 /var/logs


COPY consul.json /opt/consul/consul.json

COPY consul.ingress.hcl /opt/consul/consul.ingress.hcl

COPY init.sh /opt/consul/init.sh

COPY registeringress.sh /opt/consul/registeringress.sh

EXPOSE 21000-21005

RUN chmod +x /opt/consul/init.sh

RUN chmod +x /opt/consul/registeringress.sh


RUN apk add -u bash curl && \
    wget https://releases.hashicorp.com/consul/"${CONSUL_VERSION}"/consul_"${CONSUL_VERSION}"_linux_amd64.zip \
    -O /tmp/consul.zip && \
    unzip /tmp/consul.zip -d /tmp && \
    mv /tmp/consul /usr/local/bin/consul && \
    rm -f /tmp/consul.zip

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

