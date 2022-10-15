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
mkdir /home/vagrant/netman && cd /home/vagrant/netman
wget https://github.com/mrturkmenhub/netman/releases/download/1.0.4/netman_1.0.4_linux_64-bit.zip
unzip netman_1.0.4_linux_64-bit.zip && mv netman_1.0.4_linux_64-bit/* /home/vagrant/netman/
chmod +x /home/vagrant/netman/netman
cp /home/vagrant/uploads/netman.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable netman.service

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
#cp /home/vagrant/uploads/monitoring.service /etc/systemd/system/
#
docker-compose -f docker-compose.rrr.yml pull
docker-compose -f docker-compose.rrr.yml up -d


#Do not need daemon if docker-compose up is executed
#systemctl daemon-reload
#systemctl enable monitoring.service

#install elastic-fleet agent
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update

#cd /home/vagrant/
#curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-7.13.4-linux-x86_64.tar.gz
#tar xzvf elastic-agent-7.13.4-linux-x86_64.tar.gz
#cd elastic-agent-7.13.4-linux-x86_64

####install fleet server
#sudo ./elastic-agent install -f --url=http://localhost:8220 --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2MzAzMTQ4NjYzODg6WUk4QVN2anBUR095ZkdRVVRDLVVTZw --insecure

#sudo ./elastic-agent install -f --fleet-server-es=http://localhost:9200 --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2MzAzMTQ4NjYzODg6WUk4QVN2anBUR095ZkdRVVRDLVVTZw


systemctl daemon-reload
#systemctl enable elastic-agent


####start fleet server
#sudo ./elastic-agent install -f --fleet-server-es=http://localhost:9200 --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2MzAyMzEzMjE0MDc6c0tkMDBjd3FRV1d3Y1U0NjlZWGZ3UQ