FROM alpine

EXPOSE 5000

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
	openssl \
	supervisor && \
	mkdir /run/nginx /var/www/wordpress && \
	adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/www

COPY nginx.conf /etc/nginx/
COPY supervisord.conf /etc/

WORKDIR /var/www/wordpress/
COPY index.html .
COPY phpMyAdmin.tar.gz .
RUN mkdir phpmyadmin testindex && \
    tar zxf phpMyAdmin.tar.gz --strip 1 -C phpmyadmin && \
    rm phpMyAdmin.tar.gz
COPY config.inc.php phpmyadmin/

RUN openssl req -x509 -out /etc/ssl/certs/myserver.crt -keyout /etc/ssl/private/myserver.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=test-certificate'

CMD supervisord