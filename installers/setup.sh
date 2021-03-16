current_dir=`pwd`

# Deleting old updates
cd /var/lib/dpkg/updates
rm *
cd "$current_dir"

# Ask for update
read -ep "Update current system? (y/n): " update;
if [ "$update" == "y" ]; then
    apt update && apt upgrade -y
fi

# Ask for general Setup
read -ep "Default Setup? (y/n): " default;
if [ "$default" == "y" ]; then
    bash default_setup.sh
fi

# Ask for Gitlab
read -ep "Install Gitlab? (y/n): " gitlab;
if [ "$gitlab" == "y" ]; then
    bash gitlab.sh
else
# If not installing Gitlab, ask for a single runner
    read -ep "Install a Gitlab Runner? (y/n): " gitlab_runner;
    if [ "$gitlab_runner" == "y" ]; then
        bash gitlab_runner.sh
    fi
fi

# Ask for Java
read -ep "Install Java? (y/n): " java;
if [ "$java" == "y" ]; then
    bash java.sh
fi

# Ask for MySQL
read -ep "Install MySQL? (y/n): " mysql;
if [ "$mysql" == "y" ]; then
    bash mysql.sh
fi

# Ask for phpMyAdmin
read -ep "Install phpMyAdmin? (y/n): " phpmyadmin;
if [ "$phpmyadmin" == "y" ]; then
    bash phpmyadmin.sh
fi

cd "$current_dir"