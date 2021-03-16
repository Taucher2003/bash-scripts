echo "Installing phpmyadmin"

current_dir=`pwd`

# Install Webserver
apt install apache2 -y

# Install php
apt install php8.0 php8.0-cli php8.0-common php8.0-curl php8.0-gd php8.0-intl php8.0-mbstring php8.0-mysql php8.0-opcache php8.0-readline php8.0-xml php8.0-xsl php8.0-zip php8.0-bz2 libapache2-mod-php8.0 -y

# Change to phpMyAdmin directory
cd /usr/share

# Download phpMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip

# Unzip and remove archive
unzip phpmyadmin.zip
rm phpmyadmin.zip

# Move phpMyAdmin to final directory and set permissions
mv phpMyAdmin-*-all-languages phpmyadmin
chmod -R 0755 phpmyadmin

# Apache Configuration
echo "# phpMyAdmin Apache configuration

Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
</Directory>

# Disallow web access to directories that don't need it
<Directory /usr/share/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/setup/lib>
    Require all denied
</Directory>" >> /etc/apache2/conf-available/phpmyadmin.conf

# Activate phpMyAdmin
a2enconf phpmyadmin
systemctl reload apache2

# Temp Directory
mkdir /usr/share/phpmyadmin/tmp/
chown -R www-data:www-data /usr/share/phpmyadmin/tmp/

cd "$current_dir"