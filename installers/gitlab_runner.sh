echo "Installing a Gitlab Runner"

current_dir=`pwd`

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

if [ "$gitlab_url" != */ ]; then
    gitlab_url="$gitlab_url/"
fi

# Register Runner
read -ep "Registration Token: " registration_token;
read -ep "Description: " description;
read -ep "Tag List (seperate by ,): " tag_list;
read -ep "Run untagged: " -i "true" run_untagged;
read -ep "Locked: " -i "false" locked;
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