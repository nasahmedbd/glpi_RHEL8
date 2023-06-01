## Disable SELinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled' /etc/selinux/config
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
cat /etc/selinux/config
setenforce 0
getenforce

## Install Remi repo for latest versopn of php.
## Here will apply php version 8.2
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf module list php
dnf module enable php:remi-8.2 -y
php -v

## Add Firewall rule to allow http and https
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

## Install required packages
dnf install dnf install php  php-mbstring php-mysqlnd php-json php-gd php-intl php-ldap php-apcu php-xmlrpc php-opcache php-zip php-xmlrpc wget tar -y


## Enable Required Services
systemctl start httpd.service
systemctl enable httpd.service
systemctl enable mariadb
systemctl start mariadb

## Check php version
php -v


##https://github.com/glpi-project/glpi/releases/
	
cd /var/www/	
wget https://github.com/glpi-project/glpi/releases/download/10.0.7/glpi-10.0.7.tgz
tar -xvf glpi-10.0.7.tgz
chown -R apache:apache glpi
chmod -R 755 glpi
touch /etc/httpd/conf.d/glpi.conf 

sed -i 's/
Alias /glpi "/var/www/html/glpi/"

<Directory> /var/www/html/glpi/config>
	AllowOverride None
	Require all denied
</Directory>

<Directory> /var/www/html/glpi/files>
	AllowOverride None
	Require all denied
</Directory>


## Service Restart
systemctl restart httpd.service'  /etc/httpd/conf.d/glpi.conf 



## Configure Maria DB
mysql -u root -p

CREATE DATABASE glpidb;
CREATE USER glpidbadmin@localhost IDENTIFIED BY 'glpidbPWD';
GRANT ALL ON glpidb.* TO glpidbadmin@localhost;
FLUSH PRIVILEGES;
EXIT;

user: glpi
pw: glpi
