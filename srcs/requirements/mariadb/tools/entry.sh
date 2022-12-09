mkdir -p /home/yotak/data/db
mkdir -p /home/yotak/data/wordpress

chown -R mysql:mysql /var/lib/mysql/data
mysql_install_db --user=root \
                --basedir=/usr \
                --datadir=/var/lib/mysql

/usr/bin/mysqld --user=root --datadir=/var/lib/mysql

rc-update add mariadb && sleep 10

mysql -e "CREATE DATABASE IF NOT EXISTS '${DB}'";

mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}'";

mysql -e "GRANT ALL PRIVILEGES ON ${DB}.* TO '${DB_USER}'@'%'";

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}'";

myqle -e "FLUSH PRIVILEGES;"

# rc-service mariadb restart