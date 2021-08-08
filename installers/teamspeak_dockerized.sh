echo "Installing TeamSpeak using Docker"

current_dir=`pwd`

if [ -x "$(command -v docker-compose)" ]; then
    echo "Docker-Compose already installed"
else
    bash <(wget --no-check-certificate -O - 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/docker_compose.sh')
fi

mkdir teamspeak || true
cd teamspeak

echo "version: '3.7'

services:
    teamspeak:
        image: teamspeak:3.13.6
        restart: unless-stopped
        ports:
            - \"9987:9987/udp\"
            - \"10011:10011\"
            - \"30033:30033\"
        expose:
            - \"10011\"
        volumes:
            - \"$current_dir/teamspeak/data/:/var/ts3server/\"
        environment: 
            TS3SERVER_LICENSE: accept" >> docker-compose.yml

docker-compose up -d

cd "$current_dir"