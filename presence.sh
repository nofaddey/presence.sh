# !/bin/bash
dbpw=dbpassword
fqdn=ryanog.com 
exec >> /scriptoutput.txt
date
/bin/bash -c "$(curl -sL https://git.io/vokNn)"
cp completions/bash/apt-fast /etc/bash_completion.d/
chown root:root /etc/bash_completion.d/apt-fast
. /etc/bash_completion
sudo apt-fast --assume-yes update
sudo apt-fast --assume-yes upgrade
sudo apt-fast --assume-yes install nano
sudo apt-fast --assume-yes install dnsutils
sudo apt-fast --assume-yes install git
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password test"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password test"
sudo apt-fast -y install mysql-server
sudo apt-fast -y install nginx
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash
sudo apt-fast install -y nodejs
sudo npm i -g ghost-cli
sudo apt-fast install ufw
sudo ufw allow 'Nginx Full'
sudo ufw allow ssh
sudo ufw enable
sudo adduser test --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "test:test" | sudo chpasswd
sudo usermod -aG sudo test
sudo mkdir -p /var/www/ghost && sudo chown test:test /var/www/ghost
cd /var/www/ghost
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo -u test ghost install --url=https://$fqdn --db=mysql --dbhost=localhost --dbuser=root --dbpass=$dbpw --dbname=ghost --no-setup-ssl --no-setup-nginx  --no-prompt --start
date