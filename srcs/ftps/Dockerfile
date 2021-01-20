FROM alpine

EXPOSE 21

RUN apk update && \
	apk add \
	vsftpd \
	openssl

RUN openssl req -x509 -out /etc/ssl/certs/myserver.crt -keyout /etc/ssl/private/myserver.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=test-certificate'

CMD vsftpd
