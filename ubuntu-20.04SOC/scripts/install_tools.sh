#!/bin/bash -eux

## install wireguard
apt-get update -y
#apt-get install wireguard -y
apt-get install wget -y

## configure port forwarding ...
#modprobe wireguard
#systemctl enable wg-quick@wg0
#echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
#sysctl -p



# install net tools like ifconfig
apt-get install net-tools -y
apt-get install ifupdown -y

## install zip and unzip
apt-get install zip  -y
apt-get install unzip -y

## install netman service to manage down network interfaces
# pop up version if required
#mkdir /home/vagrant/netman && cd /home/vagrant/netman
#wget https://github.com/mrturkmenhub/netman/releases/download/1.0.4/netman_1.0.4_linux_64-bit.zip
#unzip netman_1.0.4_linux_64-bit.zip && mv netman_1.0.4_linux_64-bit/* /home/vagrant/netman/
#chmod +x /home/vagrant/netman/netman
#cp /home/vagrant/uploads/netman.service /etc/systemd/system/
#systemctl daemon-reload
#systemctl enable netman.service

## install git
apt-get install git-all -y

# install docker and docker compose
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl  gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker vagrant

# Will be managed laterb
cd /home/vagrant
git clone https://github.com/aau-network-security/nap-monitoring.git
cd /home/vagrant/nap-monitoring/
chmod +x /home/vagrant/nap-monitoring/
cp /home/vagrant/uploads/monitoring.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable monitoring.service

