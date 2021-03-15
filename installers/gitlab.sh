echo "Installing Gitlab"

# Update current system
sudo apt update

# Install general dependencies
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Update current system
sudo apt update
sudo apt install -y curl openssh-server ca-certificates perl

# Postfix Server for Gitlab
sudo apt install -y postfix

# Add Gitlab Repository Key
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

# Install Gitlab
read -ep "Gitlab EXTERNAL_URL: " gitlab_url;
sudo EXTERNAL_URL="$gitlab_url" apt install gitlab-ee

# Ask for Runner installation
read -ep "Install a Runner? (yes/no): " gitlab_runner;
if [ "$gitlab_runner" == "yes" ]; then
    bash docker.sh
    bash gitlab_runner.sh "$gitlab_url"
fi