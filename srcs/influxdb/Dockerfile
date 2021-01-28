FROM alpine

EXPOSE 8086
EXPOSE 8083

USER root

RUN apk update && \
    apk add \
    influxdb \
    telegraf \
    supervisor && \
    mkdir -p /var/lib/influxdb /etc/telegraf

COPY supervisord.conf /etc/
COPY telegraf.conf /etc/telegraf/

CMD supervisord