FROM alpine

RUN apk update && \
    apk add \
    nginx \
    php7.3 \
    php7.3-fpm \
    php7.3-mbstring \
    php7.3-zip \
    php7.3-gd \
    php7.3-xml \
    php-pear \
    php7.3-gettext \
    php7.3-cgi \
    php7.3-mysql \
    openssl && \
    adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    rm -rf /etc/nginx/nginx.conf && \
    mkdir /run/nginx

COPY index.html /www
COPY nginx.conf /etc/nginx

COPY srcs/wordpress.tar.gz .
RUN tar zxf wordpress.tar.gz --strip-components=1 && \
    rm wordpress.tar.gz
COPY srcs/wp-config.php .

RUN openssl req -x509 -out /etc/ssl/certs/myserver.crt -keyout /etc/ssl/private/myserver.key \
    -newkey rsa:2048 -nodes -sha256 \
    -subj '/CN=test-certificate'

CMD /usr/sbin/sshd && nginx -g "daemon off;"