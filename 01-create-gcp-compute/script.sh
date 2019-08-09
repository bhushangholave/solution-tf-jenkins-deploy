#!/bin/bash

set -eo pipefail

sudo su

apt-get update 
sudo apt install openjdk-8-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install jenkins -y
echo "jenkins installed"
systemctl status jenkins
echo "jenkins started"
ufw allow 8080
ufw allow OpenSSH
ufw enable
cat /var/lib/jenkins/secrets/initialAdminPassword
apt-get update
apt-get install software-properties-common
apt-add-repository ppa:ansible/ansible -y
apt-get update
apt-get install ansible -y
echo "ansible installed"
echo "end of the script"
exit

