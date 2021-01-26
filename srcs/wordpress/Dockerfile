FROM alpine

EXPOSE 5050

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
	php7-fpm \
    supervisor && \
	mkdir /run/nginx /var/www/wordpress && \
	adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/www

COPY nginx.conf /etc/nginx/
COPY supervisord.conf /etc/
COPY php-fpm.conf /etc/php7/
COPY wp-cli.phar  /usr/local/bin/wp
COPY set_users.sh /tmp/

WORKDIR /var/www/wordpress
RUN su -c 'wp core download --path=/var/www/wordpress' - www
COPY wp-config.php .

CMD /tmp/set_users.sh && supervisord