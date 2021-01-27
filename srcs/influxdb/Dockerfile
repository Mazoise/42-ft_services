FROM alpine

EXPOSE 8086
EXPOSE 8083
EXPOSE 2003

USER root

RUN apk update && \
    apk add \
    influxdb \
    telegraf \
    supervisor && \
    mkdir -p /var/lib/influxdb

COPY supervisord.conf /etc/
# COPY influxdb.conf /etc/

CMD supervisord