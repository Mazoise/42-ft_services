FROM alpine

EXPOSE 3000

RUN         apk update && \
            apk add \
            grafana

WORKDIR /usr/share/grafana/conf/
# COPY grafana.tar.gz .
# RUN tar zxf grafana.tar.gz --strip 1 && \
#     rm grafana.tar.gz
COPY provisioning ./provisioning
COPY custom.ini .

CMD grafana-server
