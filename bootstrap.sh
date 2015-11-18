#!/usr/bin/env bash
# source: http://rsabalburo.blogspot.be/2014/07/ntopng-on-ubuntu-1404-lts-server.html

apt-get update
apt-get -y upgrade

sh -c 'echo "deb http://apt.ntop.org/14.04/ x64/\ndeb http://apt.ntop.org/14.04/ all/" > /etc/apt/sources.list.d/ntop.list'

wget -qO - http://packages.ntop.org/apt/ntop.key | sudo apt-key add -
apt-get update

apt-get install -y libpcap-dev libglib2.0-dev libgeoip-dev redis-server libxml2-dev libnl1
apt-get install -y ntopng pfring nprobe ntopng-data n2disk nbox

mkdir /etc/ntopng/
cp /vagrant/ntopng.conf /etc/ntopng/ntopng.conf
cp /vagrant/ntopng.start /etc/ntopng/ntopng.start

# really useful?
sudo service redis-server restart
sudo service ntopng restart

# launch ntopng in screen
screen -d -m -S ntopng /usr/local/bin/ntopng --community