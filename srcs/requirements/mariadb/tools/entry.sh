# --user myslqd(mysql 서버)를 구동하기 위한 사용자 이름
# --basedir mysql설치 디렉토리 경로
# --datadir mysql데이터 디렉토리 경로
# https://pyrasis.com/book/DockerForTheReallyImpatient/Chapter16/02
mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql

# mysql은 설치 후 root와 *패스워드가 없는*익명 사용자를 자동으로 만듦
cat > /tmp/mysql_init << EOF
FLUSH PRIVILEGES;

ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD("'$DB_ROOT_PASSWORD'");
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$USER_ID'@'%' IDENTIFIED BY '$USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USER_ID'@'%';

FLUSH PRIVILEGES;
EOF
# mysql 스크립트 활성화
/usr/bin/mysqld --user=root --bootstrap < /tmp/mysql_init
# mysqld 활성화
/usr/bin/mysqld --user=root