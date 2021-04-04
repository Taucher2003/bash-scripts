# Bash Scripts

This repository just holds some of my bash scripts for a bit of automation.
These are currently just some installers that I made to make my life easier.

Currently there are installers for:

* Docker
* Gitlab
* Gitlab Runner
* Java
* MySQL
* phpMyAdmin

And some general things like `htop` or `ufw`.

<br>

# Repository

This is something I can use very fast and not for others to collaborate on. Therefore this will not follow a git flow and also the commit messages can be just crap.

# Usage

## Installers

Without file caching
```sh
bash <(wget --no-check-certificate -O - 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/master/installers/setup.sh')
```

With file caching
```sh
bash <(wget --no-check-certificate -O - 'https://raw.githubusercontent.com/Taucher2003/bash-scripts/1.0/installers/setup.sh')
```