# --user myslqd(mysql 서버)를 구동하기 위한 사용자 이름
# --basedir mysql설치 디렉토리 경로
# --datadir mysql데이터 디렉토리 경로
# https://pyrasis.com/book/DockerForTheReallyImpatient/Chapter16/02
mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql

# CREATE랑 GRANT사이에 들어가면 폭발....-- FLUSH PRIVILEGES;
# GRANT ALL에서 IDENTIFIED BY $USER_PASSWORD
cat > /tmp/mysql_init << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$USER_ID'@'%' IDENTIFIED BY '$USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USER_ID'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

/usr/bin/mysqld --user=root --bootstrap < /tmp/mysql_init

/usr/bin/mysqld --user=root