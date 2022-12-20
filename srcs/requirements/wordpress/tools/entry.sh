# wordpress download
wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz
cp -rf /wordpress/* /var/www > /dev/null
rm -rf /wordpress latest.tar.gz
#mariadb 전에 php가 켜지면 안됨!
sleep 30
exec php-fpm8 -F