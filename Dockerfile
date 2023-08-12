FROM ubuntu:latest
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y \
    && apt install wget mariadb-server tzdata -y \
    && apt install unzip php apache2 php-mysqlnd -y \
    && wget https://wordpress.org/latest.zip \
    && rm -rf /var/www/html/* \
    && unzip latest.zip -d /var/www/html/ \
    && mv /var/www/html/wordpress/* /var/www/html/ \
    && mv /var/www/html/wp-config-sample.php  /var/www/html/wp-config.php \
    && sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php \
    && sed -i 's/username_here/admin/g' /var/www/html/wp-config.php \
    && sed -i 's/password_here/admin123/g' /var/www/html/wp-config.php \
    && sed -i 's/localhost/database-1.cgqzznwa1v2k.us-east-1.rds.amazonaws.com/g' /var/www/html/wp-config.php

EXPOSE 3306
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
