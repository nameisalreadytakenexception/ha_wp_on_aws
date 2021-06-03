#!/bin/bash
echo "userdata-start"
sudo apt update -y
sudo apt install -y apache2 nfs-common php7.4-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip mysql-client-core-8.0 libapache2-mod-php php-mysqli
MOUNT_LOCATION="/var/www/html"
MOUNT_TARGET=${mount_target}
MY_WP_DB_NAME=${my_wp_db_name}
MY_WP_DB_USER=${my_wp_db_user}
MY_WP_DB_PASSWORD=${my_wp_db_password}
MY_WP_DB_HOST=${my_wp_db_host}
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 $MOUNT_TARGET:/ $MOUNT_LOCATION
echo $MOUNT_TARGET:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo tee -a /etc/fstab
echo -e "<Directory /var/www/html/>\n\tAllowOverride All\n</Directory>" | sudo tee -a /etc/apache2/sites-available/000-default.conf
sudo chmod go+rw /var/www/html
sudo rm -f /var/www/html/index.html

# cd /tmp && git clone https://github.com/nameisalreadytakenexception/wordpress.git
# sudo cp -rT /tmp/wordpress /var/www/html/ 
# sudo sed -i -e 's+my_db_name+$MY_WP_DB_NAME+g' /var/www/html/wp-config.php
# sudo sed -i -e 's+my_db_user+$MY_WP_DB_USER+g' /var/www/html/wp-config.php
# sudo sed -i -e 's+my_db_password+$MY_WP_DB_PASSWORD+g' /var/www/html/wp-config.php
# sudo sed -i -e 's+my_db_host+$MY_WP_DB_HOST+g' /var/www/html/wp-config.php

sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html/ -type d -exec chmod 750 {} \;
sudo find /var/www/html/ -type f -exec chmod 640 {} \;
sudo systemctl start apache2
sudo systemctl enable apache2
# echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
sudo echo "<h1>Deployed via Terraform!!!</h1>" > /var/www/html/index.html
echo "userdata-end"