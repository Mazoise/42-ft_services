FROM alpine

RUN apk update && \
	apk add \
	nginx \
	openssl && \
	adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	rm -rf /etc/nginx/nginx.conf && \
	mkdir /run/nginx

COPY index.html /www
COPY nginx.conf /etc/nginx

WORKDIR /tmp
COPY start.sh .
RUN chmod +x start.sh

# CMD sh ./start.sh
CMD nginx -g "daemon off;"
# CMD sh
