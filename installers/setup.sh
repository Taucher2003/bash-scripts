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
    if [ ! -f "default_setup.sh" ]; then
        wget --no-check-certificate -O default_setup.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/default_setup.sh'
    fi
    bash default_setup.sh
fi

# Ask for Gitlab
read -ep "Install Gitlab? (y/n): " gitlab;
if [ "$gitlab" == "y" ]; then
    if [ ! -f "gitlab.sh" ]; then
        wget --no-check-certificate -O gitlab.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/gitlab.sh'
    fi
    bash gitlab.sh
else
# If not installing Gitlab, ask for a single runner
    read -ep "Install a Gitlab Runner? (y/n): " gitlab_runner;
    if [ "$gitlab_runner" == "y" ]; then
        if [ ! -f "gitlab_runner.sh" ]; then
            wget --no-check-certificate -O gitlab_runner.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/gitlab_runner.sh'
        fi
        bash gitlab_runner.sh
    fi
fi

# Ask for Java
read -ep "Install Java? (y/n): " java;
if [ "$java" == "y" ]; then
    if [ ! -f "java.sh" ]; then
        wget --no-check-certificate -O java.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/java.sh'
    fi
    bash java.sh
fi

# Ask for MySQL
read -ep "Install MySQL? (y/n): " mysql;
if [ "$mysql" == "y" ]; then
    if [ ! -f "mysql.sh" ]; then
        wget --no-check-certificate -O mysql.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/mysql.sh'
    fi
    bash mysql.sh
else
    # If not installing MySQL, ask for single phpmyadmin
    read -ep "Install phpMyAdmin? (y/n): " phpmyadmin;
    if [ "$phpmyadmin" == "y" ]; then
        if [ ! -f "phpmyadmin.sh" ]; then
            wget --no-check-certificate -O phpmyadmin.sh 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/phpmyadmin.sh'
        fi
        bash phpmyadmin.sh
    fi
fi

cd "$current_dir"