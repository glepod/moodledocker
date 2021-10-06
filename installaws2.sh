#sudo apt install -y git
#git clone https://github.com/glepod/docker-ci_testrunner.git
#new ubuntu 20.04 installation

FILE=~/start
if [ ! -f "$FILE" ]; then
  touch ~/start
  touch ~/part1
fi

FILE=~/part1
if [ -f "$FILE" ]; then
  sudo apt install -y gcc make perl
  sudo apt update
  sudo add-apt-repository multiverse
  rm -rf ~/part1
  touch ~/part2
fi

FILE=~/.ssh/id_rsa.pub
if [ ! -f "$FILE" ]; then
  echo 'Create a ssh key and add to Catalyst and github'
  echo 'https://git.catalyst-au.net/users/sign_in'
  echo 'github.com'
  echo ''
  echo 'ssh-keygen -b 4096 -t rsa -C "your_email@example.com"'
  echo 'ssh-add ~/.ssh/id_rsa'
  exit 1
fi

FILE=~/part2
if [ -f "$FILE" ]; then
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

  rm -rf ~/part2
  touch ~/part3
fi

FILE=~/part3
if [ -f "$FILE" ]; then
  mv mount/moodle/config.php mount/
  git clone git@git.catalyst-au.net:monash/moodle-eassess.git mount/moodle
  cd mount/moodle
  git submodule update --init --recursive --jobs=8
  cd ../..
  sudo sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf
  echo 'net.ipv4.ip_unprivileged_port_start=80' | sudo tee -a /etc/sysctl.conf
  sudo service apache2 restart
  ./bin/moodle-docker-compose up -d
  mv mount/moodle/config.php mount/moodle/config.bak
  cp mount/config.php mount/moodle/
  bash rebuild.sh
  rm -rf ~/part3
  rm -rf ~/start
fi
