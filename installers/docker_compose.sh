current_dir=`pwd`

if [ -x "$(command -v docker)" ]; then
    echo "Docker already installed"
else
    bash <(wget --no-check-certificate -O - 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/docker.sh')
fi

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

if [ -x "$(command -v docker-compose)" ]; then
    docker-compose --version
else
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
fi

cd "$current_dir"