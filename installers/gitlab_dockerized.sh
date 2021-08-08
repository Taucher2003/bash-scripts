echo "Installing Gitlab using Docker"

current_dir=`pwd`

if [ -x "$(command -v docker-compose)" ]; then
    echo "Docker-Compose already installed"
else
    bash <(wget --no-check-certificate -O - 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/docker_compose.sh')
fi

mkdir gitlab || true
cd gitlab

echo "version: '3.7'

services:
    gitlab:
        image: gitlab/gitlab-ee:14.1.2-ee.0
        restart: unless-stopped
        hostname: gitlab.bl4cklist.eu
        ports:
            - \"80:80\"
            - \"443:443\"
            - \"22:22\"
        volumes:
            - \"$current_dir/gitlab/config:/etc/gitlab\"
            - \"$current_dir/gitlab/logs:/var/log/gitlab\"
            - \"$current_dir/gitlab/data:/var/opt/gitlab\"" >> docker-compose.yml

docker-compose up -d

cd "$current_dir"

