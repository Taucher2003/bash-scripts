cd /var/lib/dpkg/updates
rm *
cd /root

apt update && apt upgrade -y
apt install htop -y -f
apt install sudo -y -f