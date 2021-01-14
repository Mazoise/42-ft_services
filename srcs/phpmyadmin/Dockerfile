FROM alpine

RUN apk update && \
	apk add \
	nginx \
	php7-bz2 \
	php7-ctype \
	php7-curl \
	php7-dom \
	php7-gd \
	php7-intl \
	php7-json \
	php7-mbstring \
	php7-mysqli \
	php7-openssl \
	php7-phar \
	php7-session \
	php7-xml \
	php7-xmlreader \
	php7-zip \
	php7-zlib \
	openssl && \
	adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	rm -rf /etc/nginx/nginx.conf && \
	mkdir /run/nginx

COPY ../nginx/index.html /www
COPY ../nginx/nginx.conf /etc/nginx

WORKDIR /var/www/my_server/
COPY phpMyAdmin.tar.gz .
RUN mkdir phpmyadmin testindex && \
    tar zxf phpMyAdmin.tar.gz --strip 1 -C phpmyadmin && \
    rm phpMyAdmin.tar.gz
COPY config.inc.php phpmyadmin

RUN openssl req -x509 -out /etc/ssl/certs/myserver.crt -keyout /etc/ssl/private/myserver.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=test-certificate'

CMD php-fpm7 && nginx -g "daemon off;"