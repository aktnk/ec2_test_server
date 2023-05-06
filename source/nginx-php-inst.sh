#! /bin/bash
yum update -y
timedatectl set-timezone Asia/Tokyo
amazon-linux-extras install -y nginx1 php8.2
echo '<?php echo "Request from IP: ".$_SERVER["REMOTE_ADDR"]." at ".date(DATE_ATOM); ?>' | tee /usr/share/nginx/html/index.php
sed -i -e "s/^expose_php = On/expose_php = Off/" -e "s/^;date.timezone =/date.timezone = Asia\/Tokyo/" /etc/php.ini
echo 'server_tokens off;' | teee /etc/nginx/conf.d/default.conf
systemctl start php-fpm
systemctl start nginx
systemctl enable php-fpm
systemctl enable nginx
