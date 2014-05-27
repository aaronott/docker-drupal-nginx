#!/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then

    mysql_install_db

    /usr/bin/mysqld_safe &
    sleep 10s

    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'changeme' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
    #echo "GRANT ALL ON *.* TO admin@172.17.42.1 IDENTIFIED BY 'changeme' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

    killall mysqld
    sleep 10s
fi

/usr/bin/mysqld_safe
#if [ ! -f /var/www/sites/default/settings.php ]; then
#  # Start mysql
#  /usr/bin/mysqld_safe & 
#  sleep 10s
#  # Generate random passwords   
#  DRUPAL_DB="drupal"
#  MYSQL_PASSWORD=`pwgen -c -n -1 12`
#  DRUPAL_PASSWORD=`pwgen -c -n -1 12`
#  # This is so the passwords show up in logs. 
#  echo mysql root password: $MYSQL_PASSWORD
#  echo drupal password: $DRUPAL_PASSWORD
#  echo $MYSQL_PASSWORD > /mysql-root-pw.txt
#  echo $DRUPAL_PASSWORD > /drupal-db-pw.txt
#  mysqladmin -u root password $MYSQL_PASSWORD 
#  mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE drupal; GRANT ALL PRIVILEGES ON drupal.* TO 'drupal'@'localhost' IDENTIFIED BY '$DRUPAL_PASSWORD'; FLUSH PRIVILEGES;"
##  cd /var/www/
##  drush site-install standard -y --account-name=admin --account-pass=admin --db-url="mysqli://drupal:${DRUPAL_PASSWORD}@localhost:3306/drupal"
#  killall mysqld
#  sleep 10s
#fi
#
# start all the services
/usr/local/bin/supervisord -n
