FROM alpine

EXPOSE 8086
EXPOSE 8083

USER root

RUN apk update && \
    apk add \
    influxdb \
    telegraf \
    supervisor && \
    mkdir -p /var/lib/influxdb/data /etc/telegraf /etc/influxdb && \
    chown -R influxdb:influxdb /var/lib/influxdb/ && \
    mv /etc/influxdb.conf /etc/influxdb/influxdb.conf

COPY supervisord.conf /etc/
COPY telegraf.conf /etc/telegraf/

CMD supervisord