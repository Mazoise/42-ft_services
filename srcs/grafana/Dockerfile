FROM alpine

EXPOSE 3000

RUN         apk update && \
            apk add \

WORKDIR
COPY grafana.tar.gz .
RUN tar zxf grafana.tar.gz --strip 1 && \
    rm grafana.tar.gz

CMD grafana-server