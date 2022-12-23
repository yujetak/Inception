FROM alpine:3.16
# socket 위치 /run/mysqld/mysqld.sock
RUN mkdir -p /run/mysqld
# mariadb volumes mount위치
RUN mkdir -p /var/lib/mysql

RUN apk add mariadb \ 
            mariadb-common \
            mariadb-client \
            mariadb-server-utils
RUN apk add openrc
RUN apk update && apk upgrade

COPY ./conf/my.cnf /etc/my.cnf

RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod 777 /var/lib/mysql

COPY ./tools/entry.sh /tmp/run_mariadb.sh
RUN chmod +x /tmp/run_mariadb.sh
ENTRYPOINT ["sh", "/tmp/run_mariadb.sh"]

EXPOSE 3306
