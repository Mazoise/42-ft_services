FROM alpine

EXPOSE 3306

USER root

RUN apk update && \
    apk add mysql mysql-client

COPY my.cnf /etc/

WORKDIR /tmp
COPY config.sql .
COPY entrypoint.sh .

CMD sh /tmp/entrypoint.sh