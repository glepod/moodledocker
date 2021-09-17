WORKING_DIR=~/monash_docker
if [ -d "$WORKING_DIR" ]; then rm -Rf $WORKING_DIR; fi
cd $WORKING_DIR
sudo apt-get install -y network-manager-openconnect-gnome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
sudo -E apt -qy update
sudo -E apt -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
sudo -E apt -qy autoclean
sudo apt install -y php
sudo apt install -y curl
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
