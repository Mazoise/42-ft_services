FROM alpine

EXPOSE 20
EXPOSE 21
EXPOSE 30000

RUN apk update && \
	apk add \
	vsftpd \
	openssl

COPY vsftpd.conf /etc/vsftpd/
RUN adduser -D -h /var/ftp -g 'mchardin' "mchardin" && \
	echo "mchardin:psw" | chpasswd && \
	chown -R mchardin:mchardin /var/ftp

RUN openssl req -x509 -out /etc/ssl/certs/ftps.crt -keyout /etc/ssl/private/ftps.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=ftps-certificate'

CMD vsftpd /etc/vsftpd/vsftpd.conf