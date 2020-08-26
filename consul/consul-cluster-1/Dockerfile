#lol build users
ARG ENVOY_VERSION=1.14-latest

FROM envoyproxy/envoy-alpine:v${ENVOY_VERSION}

# ENV CONSUL_HTTP_ADDR=http://localhost:8500
# Remove env localhost

ARG CONSUL_VERSION=1.8.0

RUN apk update && apk add jq --no-cache supervisor 

RUN mkdir -p /opt/consul  \
    && mkdir -p /etc/consul.d \
    && mkdir /var/logs \
    && chmod -R 777 /opt/consul \
    && chmod -R 777 /etc/consul.d \
    && chmod -R 777 /var/logs


COPY init.sh /opt/consul/init.sh

COPY consul.sample.json /opt/consul/consul.sample.json

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /opt/consul/init.sh

RUN apk add -u bash curl && \
    wget https://releases.hashicorp.com/consul/"${CONSUL_VERSION}"/consul_"${CONSUL_VERSION}"_linux_amd64.zip \
    -O /tmp/consul.zip && \
    unzip /tmp/consul.zip -d /tmp && \
    mv /tmp/consul /usr/local/bin/consul && \
    rm -f /tmp/consul.zip


CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
