echo "Installing Gitlab"

current_dir=`pwd`

# Update current system
apt update

# Install general dependencies
apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

# Update current system
apt update
apt install -y curl openssh-server ca-certificates perl

# Postfix Server for Gitlab
apt install -y postfix

# Add Gitlab Repository Key
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

# Install Gitlab
read -ep "Gitlab EXTERNAL_URL: " gitlab_url;
EXTERNAL_URL="$gitlab_url" apt install gitlab-ee -y

# Ask for Runner installation
read -ep "Install a Runner? (y/n): " gitlab_runner;
if [ "$gitlab_runner" == "y" ]; then
    wget --no-check-certificate -O gitlab_runner.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/gitlab_runner.sh'
    bash gitlab_runner.sh "$gitlab_url"
    rm gitlab_runner.sh
fi

cd "$current_dir"