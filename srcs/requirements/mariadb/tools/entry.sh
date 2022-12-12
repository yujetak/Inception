mkdir -p /home/yotak/data/db
mkdir -p /home/yotak/data/wordpress

chown -R mysql:mysql /var/lib/mysql/data
mysql_install_db --user=root \
                --basedir=/usr \
                --datadir=/var/lib/mysql

/usr/bin/mysqld --user=root --datadir=/var/lib/mysql

rc-update add mariadb && sleep 10

mysql -e "CREATE DATABASE IF NOT EXISTS '${MARIADB_DB}'";

mysql -e "CREATE USER IF NOT EXISTS '${MARIADB_DB_USER}'@'%' IDENTIFIED BY '${MARIADB_DB_USER_PASSWORD}'";

mysql -e "GRANT ALL PRIVILEGES ON ${MARIADB_DB}.* TO '${MARIADB_DB_USER}'@'%'";

mysql -e "ALTER USER '${MARIADB_ROOT}'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}'";

mysql -e "FLUSH PRIVILEGES;"

rc-service mariadb restart