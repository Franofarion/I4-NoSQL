#!/bin/bash

#Option Remove
if [[ $1 == "-remove" ]]
then

#Remove MongoDB
sudo service mongod stop
sudo yum erase $(rpm -qa | grep mongodb-org)
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongo

else #Install MongoDB

#Remove Repo File
sudo rm -rf /etc/yum.repos.d/mongod*
sudo yum clean all

#Create Repo File
touch /etc/yum.repos.d/mongodb-org-3.6.repo
echo '[mongodb-org-3.6]' > /etc/yum.repos.d/mongodb-org-3.6.repo
echo 'name=MongoDB Repository' >> /etc/yum.repos.d/mongodb-org-3.6.repo
echo 'baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/' >> /etc/yum.repos.d/mongodb-org-3.6.repo
echo 'gpgcheck=1' >> /etc/yum.repos.d/mongodb-org-3.6.repo
echo 'enabled=1' >> /etc/yum.repos.d/mongodb-org-3.6.repo
echo 'gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc' >> /etc/yum.repos.d/mongodb-org-3.6.repo

#Install Mongo/start and check installation
sudo yum install -y mongodb-org
sudo service mongod start
cat /var/log/mongodb/mongod.log

fi
