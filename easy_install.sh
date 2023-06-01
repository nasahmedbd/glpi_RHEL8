#!/bin/bash

clear

cd

HOMEpath="/root"

rep=""

echo -e "\n\n\n-------------------------\n| Welcome |\n-------------------------\n\nNasim Ahmed\nFollow the easy steps and install glpi. Will install Glpi \n\n------------------------------------------------------------"

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to download GLPI ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    while [ -z $glpi_link ];
    do

        echo -e "\nPlease, put the url for downloading GLPI :"

        read glpi_link

    done

    UseWebForGLPI="True"

else

    while [ -z $glpi_link ];
    do

        echo -e "\nPlease, put the location of the compressed file of GLPI (put the full link with \".tgz\" at the end) :"

        read glpi_link

    done

    UseWebForGLPI="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to install MariaDB on this machine ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    InstallMariaDB="True"

    rep=""

    until [ "$rep" = "y" ] || [ "$rep" = "n" ];
    do

        echo -e "\nDo you want to generate secure passwords for the database ? (y/n)"

        read rep

    done

    if [ "$rep" = "y" ];
    then

        GenDBPass="True"

    else

        GenDBPass="False"

        var1=""
        var2=""

        while [ -z $var1 ] || [ -z $var2 ] || [ $var1 != $var2 ];
        do

            echo -e "\n\nPlease, enter the password for the user \"root\" for the database :"

            read -s -p "Password : " var1

            echo

            read -s -p "Repeat : " var2

            echo

        done

        DbRootPassword="$var1"

        var1=""
        var2=""

        while [ -z $var1 ] || [ -z $var2 ] || [ $var1 != $var2 ]; do

            echo -e "\n\nPlease, enter the password for the user \"glpi\" for the database :"

            read -s -p "Password : " var1

            echo

            read -s -p "Repeat : " var2

            echo

        done

        DbUserPassword="$var1"

    fi

else

    InstallMariaDB="False"

fi

echo -e "\nList of Supported Timezones : https://www.php.net/manual/en/timezones.php"
echo -e "Please, specify the continent of the time zone where the server is (For exemple \"Asia\") :"

read Tz1

if [ ! -z $Tz1 ];
then

	echo -e "\nPlease, specify the nearest city of the time zone where the server is (For exemple \"Dhaka\") :"

	read Tz2

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to install Fusion Inventory on GLPI ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    AddFusionInventory="True"

    rep=""

    until [ "$rep" = "y" ] || [ "$rep" = "n" ];
    do
    
        echo -e "\nDo you want to download Fusion Inventory ? (y/n)"

        read rep

    done

    if [ "$rep" = "y" ];
    then

        while [ -z $fi_link ];
        do

            echo -e "\nPlease, put the url for downloading Fusion Inventory :"

            read fi_link

        done

        UseWebForFI="True"

    else

        while [ -z $fi_link ];
        do

            echo -e "\nPlease, put the location of the compressed file of Fusion Inventory (put the full link with \".tar.bz2\" at the end) :"

            read fi_link

        done

        UseWebForFI="False"

    fi

else

    AddFusionInventory="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to configure SSL/TLS with a new Certification Authority (for HTTPS access) ? (y/n)\nThe script will automatically create self signed CA certificates and configure apache for this.\nIn the case where you would already have a CA, you will be able to replace the certificates in the apache ssl configuration file."

    read rep

done

if [ "$rep" = "y" ];
then

	AddHTTPS="True"

	while [ -z $HostName ];
	do

	echo -e "\nWhat will be the host name of the website ? For exemple in \"glpi.mydom.local\" this will be \"glpi\""
	read HostName

	done

    while [ -z $DomainName ];
	do

	echo -e "\nWhat will be the domain name of the website ? For exemple in \"glpi.mydom.local\" this will be \"mydom.local\""
	read DomainName

	done

    WebSiteName=$(echo "$HostName.$DomainName")

	while [ -z $Country ];
	do

	echo -e "\nWhat country code will be displayed on the certificate ? For example FR (for France)"
	read Country

	done

	while [ -z $State ];
	do

	echo -e "\nWhich state will be displayed on the certificate ? For exemple \"Ile-De-France\""
	read State

	done

	while [ -z $City ];
	do

	echo -e "\nWhich city will be displayed on the certificate ? For exemple \"Paris\""
	read City

	done

	while [ -z $Company ];
	do

	echo -e "\nWhich company will be displayed on the certificate ?"
	read Company

	done

else

	AddHTTPS="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to configure the firewall (ufw) ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    AddFirewall="True"

else

    AddFirewall="False"

fi

echo -e "\nWhat port do you want to use for SSH ? (Port 22 by default)"

read SSHPort

if [ -z $SSHPort ];
then

    SSHPort="22"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to configure ModSecurity ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    AddModSec="True"

else

    AddModSec="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    clear

    echo -e "\nLink for GLPI : $glpi_link\n"

    echo -e "Add MariaDB : $InstallMariaDB\n"

    if [ "$InstallMariaDB" = "True" ];
    then

        echo -e "Generate passwords for db : $GenDBPass\n"

    fi

    if [ -z $Tz1 ];
    then

        echo -e "Timezone : No timezone\n"

    else

        echo -e "Timezone : $Tz1/$Tz2\n"
    
    fi

    echo -e "Add Fusion Inventory : $AddFusionInventory\n"

    if [[ "$AddFusionInventory" == "True" ]];
    then

        echo -e "Link for FI : $fi_link\n"

    fi

    echo -e "Add HTTPS : $AddHTTPS\n"

    if [[ "$AddHTTPS" == "True" ]];
    then

        echo -e "Web site name : $WebSiteName\nCountry : $Country\nState : $State\nCity : $City\nCompany : $Company\n"

    fi

    echo -e "Add firewall : $AddFirewall\n"

    echo -e "SSH port : $SSHPort\n"

    echo -e "Add ModSecurity : $AddModSec\n"

    echo -e "\n\nDo you confirm ? (y/n)\n----------------------"

    read rep

done

if [ "$rep" = "n" ];
then

    exit

fi

echo -e "\n---------------------------------------------------------\nUpdating the Remi repo and php latest packages...\n"

dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf module list php
dnf module enable php:remi-8.2 -y



echo -e "\n---------------------------------------------------------\nInstalling php...\n"

dnf install php-mysqli -y
dnf install php-mbstring -y
dnf install php-curl -y
dnf install php-gd -y
dnf install php-simplexml -y
dnf install php-intl -y
dnf install php-ldap -y
dnf install php-apcu -y
dnf install php-xmlrpc -y
dnf install php-cas -y
dnf install php-zip -y
dnf install php-bz2 -y
dnf install php-ldap -y
dnf install php-imap -y


echo -e "\n---------------------------------------------------------\nUpdating Apache HTTP Server...\n"

dnf update httpd.service

echo -e "\n---------------------------------------------------------\nStarting and Enabling Apache HTTP Server...\n"

systemctl start httpd
systemctl enable httpd


if [ "$InstallMariaDB" = "True" ];
then

   dnf install MariaDB-server MariaDB-client

fi

if [ "$InstallMariaDB" == "True" ];
then

    echo -e "\n---------------------------------------------------------\nConfiguring databases...\n"

    if [[ "$GenDBPass" == "True" ]];
    then

        DbRootPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

        echo -e "\n\nThe password for the user \"root\" for the database is : $DbRootPassword" > $HOMEpath/confidential.txt

        DbUserPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

        echo -e "\nThe password for the user \"glpi\" for the database is : $DbUserPassword\n\nPlease, delete this file after recovering the passwords.\n\n" >> $HOMEpath/confidential.txt

        chmod 700 $HOMEpath/confidential.txt

    fi

    mysql -u root -e "CREATE DATABASE glpi;"

    mysql -u root -e "GRANT ALL PRIVILEGES ON glpi.* to 'glpi'@'localhost' IDENTIFIED BY '$DbUserPassword';"

    mysql -u root -e "DROP USER IF EXISTS ''@'localhost';"

    mysql -u root -e "DROP DATABASE IF EXISTS test;"

    mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

    mysql -u root -e "FLUSH PRIVILEGES;"

    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DbRootPassword';"

fi

echo -e "---------------------------------------------------------\nConfiguring apache...\n"

sed -i "/DocumentRoot/a\\\t<Directory \/var\/www\/html\/glpi>\n\t\t\tOptions Indexes FollowSymLinks\n\t\t\tAllowOverride All\n\t\t\tRequire all granted\n\t<\/Directory>\n" /etc/apache2/sites-available/000-default.conf

sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/glpi/g" /etc/apache2/sites-available/000-default.conf

echo -e "---------------------------------------------------------\nInstallating GLPI...\n"

if [ -d "/tmp/install" ]; 
then

    rm -rf /tmp/install

fi

mkdir -p /tmp/install/GLPI-Sources

cd /tmp/install/GLPI-Sources

if [ "$UseWebForGLPI" = "True" ];
then

    wget "$glpi_link"

else

    mv "$glpi_link" .

fi

tar -xvzf $(ls)
rm /var/www/html/index.html
cp -r glpi /var/www/html/
chown -R www-data:www-data /var/www/html
echo -e "\n---------------------------------------------------------\nConfiguring php...\n"

phpv=$(ls -F /etc/php/ | grep / | head -1 | cut -d'/' -f1)

if [ ! -z $Tz2 ];
then

	sed -i -e "s/;date.timezone =/date.timezone = "$Tz1"\/"$Tz2"/g" /etc/php/$phpv/cli/php.ini

fi

sed -i -e "s/max_execution_time = 30/max_execution_time = 600/g" /etc/php/$phpv/cli/php.ini
sed -i -e "s/file_uploads = off/file_uploads = on/g" /etc/php/$phpv/cli/php.ini
sed -i -e "s/memory_limit =.*/memory_limit = -1/g" /etc/php/$phpv/cli/php.ini
echo "* * * * * php /var/www/html/glpi/front/cron.php &>/dev/null" >> /var/spool/cron/crontabs/root
chown root:crontab /var/spool/cron/crontabs/root

if [ "$AddFusionInventory" = "True" ];
then

    echo -e "---------------------------------------------------------\nInstalling Fusion Inventory...\n"

    mkdir -p /tmp/install/FusionInventory-Sources

    cd /tmp/install/FusionInventory-Sources

    if [ "$UseWebForFI" = "True" ];
    then

        wget "$fi_link"

    else

        mv "$fi_link" .

    fi

    tar -xvf $(ls)
    cp -r fusioninventory /var/www/html/glpi/plugins/
    chown -R www-data:www-data /var/www/html/glpi/plugins
    rm /var/www/html/glpi/plugins/remove.txt

fi

addr=$(hostname -I | awk '$1=$1')

if [ "$AddHTTPS" = "True" ];
then

	echo -e "\n---------------------------------------------------------\nConfiguring SSL/TLS...\n"

    sed -i -e "s/;session.cookie_secure =/session.cookie_secure = On/g" /etc/php/$phpv/apache2/php.ini

    sed -i -e "s/session.cookie_httponly =/session.cookie_httponly = On/g" /etc/php/$phpv/apache2/php.ini

	apt-get install libnss3-tools -y

	mkdir /etc/ssl/glpi

	cd /etc/ssl/glpi

	openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout rootCA.key -out rootCA.pem -subj "/C=$Country/ST=$State/L=$City/O=$Company/CN=$WebSiteName"

	openssl x509 -outform pem -in rootCA.pem -out rootCA.crt

	echo -e "authorityKeyIdentifier=keyid,issuer\nbasicConstraints=CA:FALSE\nkeyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment\nsubjectAltName = @alt_names\n[alt_names]\nIP.1 = $addr\nDNS.1 = $WebSiteName\nDNS.2 = $HostName" > domains.ext

	openssl req -new -nodes -newkey rsa:2048 -keyout GLPI.key -out GLPI.csr -subj "/C=$Country/ST=$State/L=$City/O=$Company/CN=$WebSiteName"

	cp GLPI.key /etc/ssl/private/

	openssl x509 -req -sha256 -days 1024 -in GLPI.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -extfile domains.ext -out GLPI.crt

	cp GLPI.crt /etc/ssl/certs/

  sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/glpi/g" /etc/apache2/sites-available/default-ssl.conf
	sed -i "/DocumentRoot/i\\\t\tServerName $WebSiteName" /etc/apache2/sites-available/default-ssl.conf
	sed -i -e "s/SSLCertificateFile.*/SSLCertificateFile\t\/etc\/ssl\/certs\/GLPI.crt/g" /etc/apache2/sites-available/default-ssl.conf
	sed -i -e "s/SSLCertificateKeyFile.*/SSLCertificateKeyFile\t\/etc\/ssl\/private\/GLPI.key/g" /etc/apache2/sites-available/default-ssl.conf
	sed -i "/DocumentRoot/a\\\t\t<Directory \/var\/www\/html\/glpi>\n\t\t\tOptions Indexes FollowSymLinks\n\t\t\tAllowOverride All\n\t\t\tRequire all granted\n\t\t<\/Directory>" /etc/apache2/sites-available/default-ssl.conf
	sed -i "/DocumentRoot/i\\\tServerName $WebSiteName\n\tRedirect \/ https:\/\/$addr\/" /etc/apache2/sites-available/000-default.conf
	echo "ServerName $WebSiteName" >> /etc/apache2/apache2.conf
	a2enmod ssl
	a2ensite default-ssl
	cp /etc/ssl/glpi/rootCA.crt $HOMEpath
	cp /etc/ssl/glpi/rootCA.pem $HOMEpath

fi


if [ "$AddFirewall" = "True" ];
then

    echo -e "\n---------------------------------------------------------\nConfiguring firewall...\n"
    apt install ufw -y
    ufw allow $SSHPort/tcp
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw allow 62354/tcp
    ufw default allow outgoing
    ufw default deny incoming

fi

echo -e "\n---------------------------------------------------------\nRestarting services...\n"

systemctl restart httpd

echo -e "----------------------------------------------------------------\n\nTo continue the installation, go to : http://$addr/\n"

if [ "$AddFirewall" = "True" ];
then

    echo -e "Don't forget to enable the firewall with the command : \"sudo ufw enable\"\n\n"

fi
