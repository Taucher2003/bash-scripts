echo "Installing a Gitlab Runner"

current_dir=`pwd`

if [ ! -f "docker.sh" ]; then
    wget --no-check-certificate -O docker.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/docker.sh'
fi
bash docker.sh

# Update current system
apt update

# Run Docker Image
read -ep "Container Name: " container_name;
docker run -d --name "$container_name" --restart always \
    -v /srv/gitlab-runner/"$container_name"/config:/etc/gitlab-runner \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gitlab/gitlab-runner:latest

# Check if gitlab url is empty
if [ "$1" == "" ]; then
    read -ep "Gitlab URL: " gitlab_url;
else
    gitlab_url="$1"
fi

# If gitlab_url does not end with /, add it to the end
if [ "$gitlab_url" != */ ]; then
    gitlab_url="$gitlab_url/"
fi

# Ask for registration data
read -ep "Registration Token: " registration_token;
read -ep "Description: " description;
read -ep "Tag List (seperate by ,): " tag_list;

# Make these two answers idiotic proof, only true and false allowed
while :
do
    read -ep "Run untagged (true/false): " -i "true" run_untagged;
    if [ "$run_untagged" == "true" ]; then
        break;
    fi
    if [ "$run_untagged" == "false" ]; then
        break;
    fi
done


while :
do
    read -ep "Locked (true/false): " -i "false" locked;
    if [ "$locked" == "true" ]; then
        break;
    fi
    if [ "$locked" == "false" ]; then
        break;
    fi
done

# Register the Runner
docker exec -ti "$container_name" gitlab-runner register \
  --non-interactive \
  --url "$gitlab_url" \
  --registration-token "$registration_token" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "$description" \
  --tag-list "$tag_list" \
  --run-untagged="$run_untagged" \
  --locked="$locked" \
  --access-level="not_protected"

cd "$current_dir"