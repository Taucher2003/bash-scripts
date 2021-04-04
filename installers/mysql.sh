echo "Installing MySQL / MariaDB"

current_dir=`pwd`

# Update current system
apt update
apt upgrade -y

# Install dependencies
apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y

# Add Repository Key
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# Update current system to load from new repository
apt update

# Install MariaDB
apt install mariadb-server mariadb-client -y

# Setup MariaDB
mysql_secure_installation

read -ep "Install phpMyAdmin? (y/n): " phpmyadmin;
if [ "$phpmyadmin" == "y" ]; then
    bash <(wget --no-check-certificate -O - 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/phpmyadmin.sh')
fi

cd "$current_dir"