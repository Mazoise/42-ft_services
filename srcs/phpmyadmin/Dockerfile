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
	php7-fpm \
	supervisor && \
	mkdir -p /run/nginx /var/www/phpmyadmin/tmp && \
	adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/www && \
	chown -R www:www /var/www/phpmyadmin/tmp

COPY nginx.conf /etc/nginx/
COPY supervisord.conf /etc/
COPY php-fpm.conf /etc/php7/

WORKDIR /var/www/phpmyadmin
COPY phpmyadmin.tar.gz .
RUN tar zxf phpmyadmin.tar.gz --strip 1 && \
    rm phpmyadmin.tar.gz
COPY config.inc.php .

CMD supervisord