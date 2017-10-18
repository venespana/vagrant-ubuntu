#! /usr/bin/env bash
add_ppa() {
    for i in "$@"; do
        grep -h "^deb.*$i" /etc/apt/sources.list.d/* > /dev/null 2>&1
        if [ $? -ne 0 ]
        then
            echo "Adding ppa:$i"
            apt-add-repository -y ppa:$i
        else
            echo "ppa:$i already exists"
        fi
    done
}

configure_mysql(){
    debconf-set-selections <<< "mysql-server mysql-server/root_password password $1"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $1"
    apt-get install -y mysql-server
}

declare -a INSTALLS=( 
    'apache2'
    'php7.1'
    'mysql-server'
    'php7.1-mysql'
    'php-mbstring'
    'php-zip'
)

declare -a INITD=(
    'apache2'
    'mysql'
)

#Mysql Configs
DBUSER=root
DBPASS=root

dpkg --configure -a
apt-get update
apt-get upgrade -y
add_ppa ondrej/php

for install in "${INSTALLS[@]}"; do
    echo -e "\n**************Trying to install $install**************\n"
    echo ""
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*$install" >/dev/null; then
        echo "Already installed $install"
    else
        echo ""
        echo -e "\n-----------START INSTALLING $install-----------\n"
        echo "Installing $install"
        if [ $install = "mysql-server" ]; then
            configure_mysql $DBPASS
        else
            apt-get install -y $install
        fi
        echo "Sucessfully install $install"
        echo -e "\n-----------END INSTALLING $install-----------\n"
        echo ""
    fi
done


echo -e "\n**************START ADD TO init.d**************\n"
for service in "${INITD[@]}"; do
    echo -e "\n     Adding $service\n"
    update-rc.d $service defaults
done
echo -e "\n**************END ADD TO init.d**************\n"

if dpkg --get-selections | grep -q "^$pkg[[:space:]]*apache2" >/dev/null; then

    if ! grep -Fxq "ServerName localhost" /etc/apache2/apache2.conf; then
        echo "ServerName localhost" >> /etc/apache2/apache2.conf
        cat /etc/apache2/apache2.conf
    fi

    if [ ! -d "/var/www/html/phpmyadmin" ]; then
        echo -e "\n**************Trying to install PphMyadmin**************\n"
        echo -e "       Downloading phpMyAdmin-4.7.4"
        wget https://files.phpmyadmin.net/phpMyAdmin/4.7.4/phpMyAdmin-4.7.4-all-languages.tar.gz
        echo -e "       Decompress phpMyAdmin-4.7.4"
        tar -zxvf phpMyAdmin-4.7.4-all-languages.tar.gz
        echo -e "       Move phpMyAdmin-4.7.4 to /var/www/phpmyadmin"
        mv phpMyAdmin-4.7.4-all-languages /var/www/html/phpmyadmin
        echo -e "       Remove phpMyAdmin-4.7.4 package"
        rm phpMyAdmin-4.7.4-all-languages.tar.gz
    fi

    echo -e "\n\nRestart apche2 service\n"
    service apache2 restart;
    service apache2 status;
fi

if dpkg --get-selections | grep -q "^$pkg[[:space:]]*mysql" >/dev/null; then
    echo -e "\n\nRestart mysql service\n"
    service mysql restart;
    service mysql status;
fi