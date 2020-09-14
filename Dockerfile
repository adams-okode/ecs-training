FROM python:3.6.1-alpine
WORKDIR /project
# ADD . /project
RUN apk -U add ca-certificates
RUN apk update && apk upgrade && apk add git bash build-base sudo
RUN git clone https://github.com/edenhill/librdkafka.git && cd librdkafka && ./configure --prefix /usr && make && make install

# RUN pip install --upgrade pip
# RUN pip install -r requirements.txt
# EXPOSE 8080

# RUN pip install confluent-kafka

# RUN chmod +x /project/zero.sh
# CMD ["python","manage.py","run"]
# rebuild
# ENTRYPOINT [ "/project/zero.sh" ]