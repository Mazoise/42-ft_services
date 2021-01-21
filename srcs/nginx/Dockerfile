FROM alpine

EXPOSE 80
EXPOSE 443
EXPOSE 22

ENV USER		mchardin
ENV PASSWORD	psw

RUN apk update && \
	apk add \
	nginx \
	openssh \
	supervisor \
	openssl && \
	adduser -D -g 'www' www && \
	mkdir /run/nginx && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/www

COPY index.html /var/www/
COPY nginx.conf /etc/nginx/
COPY supervisord.conf /etc/

RUN openssl req -x509 -out /etc/ssl/certs/myserver.crt -keyout /etc/ssl/private/myserver.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=test-certificate'

RUN ssh-keygen -A
RUN adduser -D ${USER} && echo ${USER}:${PASSWORD} | chpasswd 

CMD supervisord