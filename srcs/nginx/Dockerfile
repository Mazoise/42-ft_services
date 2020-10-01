FROM alpine

ENV USER		admin
ENV PASSWORD	psw

RUN apk update && \
	apk add \
	nginx \
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

RUN openssl req -x509 -out /etc/ssl/certs/myserver.crt -keyout /etc/ssl/private/myserver.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=test-certificate'

RUN ssh-keygen -A
RUN adduser -D ${USER} && echo ${USER}:${PASSWORD} | chpasswd 

CMD /usr/sbin/sshd && nginx -g "daemon off;"