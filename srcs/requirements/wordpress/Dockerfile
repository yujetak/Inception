FROM alpine:3.16

RUN mkdir -p /var/www/html
RUN apk update && apk upgrade
# install package (considering alpine version)
RUN apk add php8 php8-fpm php8-cli php8-mysqli php8-mbstring php8-xml php8-iconv 
RUN apk add lighttpd vim curl wget

RUN apk update
# nginx access
# RUN apk add shadow
# nginx permitted user 'nginx' && php permitted user 'www-data' -> match user 'www-data'
RUN adduser -u 82 -D -S -G www-data www-data
RUN chown -R www-data:www-data /var/www/html

COPY ./conf/wp-config.php /var/www/html/
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./tools/entry.sh /tmp/run_wordpress.sh
RUN chmod +x /tmp/run_wordpress.sh
ENTRYPOINT [ "sh", "/tmp/run_wordpress.sh" ]

EXPOSE 9000
