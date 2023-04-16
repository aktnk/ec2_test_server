#! /bin/bash
sudo yum update -y
sudo timedatectl set-timezone Asiz/Tokyo
sudo amazon-linux-extras install -y nginx1
sudo amazon-linux-extras install -y php8.2
echo '<?php echo "Request from IP: ".$_SERVER["REMOTE_ADDR"]." at ".date(DATE_ATOM); ?>' | sudo tee /usr/share/nginx/html/index.php
sudo sed -i -e "s/^expose_php = On/expose_php = Off/" -e "s/^;date.timezone =/date.timezone = Asia\/Tokyo" /etc/php.ini
echo 'server_tokens off;' | sudo tee /etc/nginx/conf.d/default.conf
sudo systemctl start php-fpm
sudo systemctl start nginx
sudo systemctl enable php-fpm
sudo systemctl enable nginx
