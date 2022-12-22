# mysql 켜질 때까지!
sleep 10

# https://make.wordpress.org/cli/handbook/guides/installing/
# wp-cli installation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
# wp-cli download
cd /var/www
echo "wp core download"
wp core download --allow-root --path=/var/www # ㅇㅕ기까지 너 무 잘 됨

# wp-config.php랑 wp core install이랑 충돌이 나는 듯함
# cp /tmp/wp-config.php /var/www/wp-config.php
echo "wp config create"
wp config create \
									--path=/var/www
									--allow-root \
									--dbname=wordpress \
									--dbuser=yotak \
									--dbpass=yotak42 \
									--dbhost=mariadb
echo "wp core install"
wp core install \
									--allow-root --path=/var/www \
									--url=yotak.42.fr \
									--title=Inception \
									--admin_user=yotak \
									--admin_password=yotak42 \
									--admin_email=yotak@student.42seoul.kr \
									--skip-email
echo "wp user create"
wp user create \
							yuje yuje@student.forest.kr \
							--role=author \
							--user_pass=yuje42 \

# wp core install --allow-root --path="/var/www" \
# 								--url="yotak.42.fr" \
# 								--title="Inception" \
# 								--admin_user="wp" \
# 								--admin_password="wp42" \
# 								--admin_email="yotak@student.42seoul.kr" \
# 								--skip-email

# wp user create "wp" "yotak@student.42seoul.kr" \
# 							--allow-root --path="/var/www" \
# 							--role=author \
# 							--user_pass="wp42"
echo "finished!!!!!!!!!!!!!!"
#mariadb 전에 php가 켜지면 안됨!
sleep 5
exec php-fpm8 -F