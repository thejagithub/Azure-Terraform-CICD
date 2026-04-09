#!/bin/bash
set -e

apt-get update -y

# Add Pritunl repo for Ubuntu 22.04 jammy
echo "deb https://repo.pritunl.com/stable/apt jammy main" > /etc/apt/sources.list.d/pritunl.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A

# Add MongoDB repo
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-6.0.list

apt-get update -y
apt-get install -y pritunl mongodb-org

systemctl enable mongod pritunl
systemctl start mongod pritunl