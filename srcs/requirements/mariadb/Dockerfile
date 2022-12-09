FROM alpine:3.16
RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql

RUN apk update && apk upgrade

RUN apk add openrc
RUN apk add mariadb mariadb-common mariadb-client mariadb-server-utils

COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/entry.sh /tmp/run_mariadb.sh

RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod 777 -R /var/run/mysqld
RUN chmod 777 -R /var/lib/mysql

RUN chmod +x /tmp/run_mariadb.sh
ENTRYPOINT ["sh", "/tmp/run_mariadb.sh"]

EXPOSE 3306
