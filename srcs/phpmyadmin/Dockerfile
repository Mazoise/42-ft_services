FROM alpine

ENV USER		mchardin
ENV PASSWORD	psw

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
	openssh \
	openssl && \
	adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	rm -rf /etc/nginx/nginx.conf && \
	mkdir /run/nginx

COPY index.html /www
COPY nginx.conf /etc/nginx

WORKDIR /var/www/my_server/
COPY srcs/phpMyAdmin.tar.gz .
RUN mkdir phpmyadmin testindex && \
    tar zxf phpMyAdmin.tar.gz --strip-components=1 -C phpmyadmin && \
    rm phpMyAdmin.tar.gz
COPY srcs/config.inc.php phpmyadmin

RUN openssl req -x509 -out /etc/ssl/certs/myserver.crt -keyout /etc/ssl/private/myserver.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=test-certificate'

RUN ssh-keygen -A
RUN adduser -D ${USER} && echo ${USER}:${PASSWORD} | chpasswd 

CMD /usr/sbin/sshd && nginx -g "daemon off;"