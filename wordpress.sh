#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install apache2 -y
sudo apt install mysql-server mysql-client -y
sudo apt install wget php php-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl} -y
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
sudo mv wordpress/* /var/www/html/
sudo rm /var/www/html/index.html
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
WP_DATABASE="wordpress_db"
WP_USER="abc"
WP_HOST="localhost"
WP_PASSWORD="1"
MYSQL_USER="root"
MYSQL_PASSWORD="2"
sudo mysql -e "CREATE DATABASE $WP_DATABASE;"
sudo mysql -e "CREATE USER '$WP_USER'@'$WP_HOST' IDENTIFIED BY '$WP_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $WP_DATABASE.* TO '$WP_USER'@'$WP_HOST';"
sudo mysql -e "FLUSH PRIVILEGES;"
WP_CONFIG="/var/www/html/wp-config.php"
sudo sed -i "s/database_name_here/$WP_DATABASE/" $WP_CONFIG
sudo sed -i "s/username_here/$WP_USER/" $WP_CONFIG
sudo sed -i "s/password_here/$WP_PASSWORD/" $WP_CONFIG
sudo chown -R www-data:www-data /var/www/html/
sudo systemctl restart apache2
sudo systemctl restart mysql
sudo systemctl enable apache2
sudo systemctl enable mysql
#if firwall is active and mysql port is not allow
sudo ufw allow 3306
#if port 80 is not allow
sudo ufw allow 80
echo "done"

