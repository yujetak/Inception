# docker build image automatically by reading the instructions from a dockerfile
# FROM creates a layer from 'alpine:latest' docker image
FROM alpine:3.16
# RUN build your application
RUN apk add nginx
RUN mkdir -p /var/www/
# COPY add files from your docker client's current directory
COPY ./tools/entry.sh /tmp/run_nginx.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
# SET cert directory
RUN mkdir -p /etc/nginx/ssl
RUN chmod 700 /etc/nginx/ssl
# MAKE certification
RUN apk add openssl
RUN apk upgrade && apk update
RUN openssl req -x509 \
								-newkey rsa:2048 \
								-days 365 \
								-nodes \
								-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=yotak" \
								-keyout /etc/nginx/ssl/localhost.yotak.key \
								-out /etc/nginx/ssl/localhost.yotak.crt

# RUN apk add openrc
RUN chmod +x /tmp/run_nginx.sh
ENTRYPOINT [ "sh", "/tmp/run_nginx.sh" ]

EXPOSE 443