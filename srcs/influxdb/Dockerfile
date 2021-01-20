FROM alpine

EXPOSE 8086

USER root

RUN apk update && \
    apk add influxdb

CMD influxdb