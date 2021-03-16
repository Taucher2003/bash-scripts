echo "Installing Java"

current_dir=`pwd`

apt update && apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common -y && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && apt update && apt install adoptopenjdk-8-hotspot -y && java -version

cd "$current_dir"