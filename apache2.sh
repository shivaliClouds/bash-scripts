apt update -y
apt install apache2 php php-mysql mysql-server unzip -y
a2dismod mpm_event 
a2enmod php8.3 


#wordpress
wget https://wordpress.org/latest.zip
unzip latest.zip
rm latest.zip
cp -r wordpress/* /var/www/html
rm wordpress
rm /var/www/html/index.html

#change permissions
chown -R www-data:www-data /var/www/html/

#Apache file
cd /etc/apache2/sites-available
mv 000-default.conf  wordpress.conf
a2ensite wordpress.conf
systemctl reload apache2
echo "done"

