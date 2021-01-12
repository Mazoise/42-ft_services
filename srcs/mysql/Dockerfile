FROM alpine

EXPOSE 3306
USER root

RUN apk update && \
    apk add mysql mysql-client

COPY my.cnf /etc/my.cnf

WORKDIR /tmp
COPY config.sql .
RUN mysql_install_db --user=mysql

CMD mysqld