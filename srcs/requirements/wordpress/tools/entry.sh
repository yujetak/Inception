# wordpress download
wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz
mv /wordpress/* /var/www/html
rm -rf /wordpress latest.tar.gz

exec php-fpm7 -F