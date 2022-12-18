mkdir -p /home/yotak/data/db
mkdir -p /home/yotak/data/www

# chown -R mysql:mysql /var/lib/mysql/data
# --user myslqd(mysql 서버)를 구동하기 위한 사용자 이름
# --basedir mysql설치 디렉토리 경로
# --datadir mysql데이터 디렉토리 경로
mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql

/usr/bin/mysqld --user=root --datadir=/var/lib/mysql

rc-update add mariadb && sleep 10

mysql -e "CREATE DATABASE IF NOT EXISTS wordpress";

mysql -e "CREATE USER IF NOT EXISTS yotak@'%' IDENTIFIED BY yotak42";

mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO yotak@'%'";

mysql -e "ALTER USER root@'localhost' IDENTIFIED BY root42";

mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -proot42 shutdown

rc-service mariadb restart

exec php-fpm8 -F