#!/bin/bash

# set -e
COMPONENT=mongodb
source components/common.sh

echo -n -e "\e[32mdownloading componenets \e[0m:"
curl -s -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo   &>> $LOGFILE
stat $?

echo -n -e "\e[32minstalling monodb \e[0m:"
yum install -y $COMPONENT-org  &>> $LOGFILE
stat $?

echo -n -e "\e[32m open the ip address \e[0m:"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf 
stat $?

echo -n -e "\e[32m starting mongodb \e[0m:"
systemctl enable mongod &>> $LOGFILE
systemctl start mongod &>> $LOGFILE
stat $?

echo -n -e "\e[32m downloading componenets \e[0m:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n -e "\e[32m unzipping componenets \e[0m:"
cd /tmp
unzip $COMPONENT.zip &>> $LOGFILE
stat $?

echo -n -e "\e[32m injecting schema \e[0m:"
cd $COMPONENT-main
mongo < catalogue.js  &>> $LOGFILE
mongo < users.js  &>> $LOGFILE
stat $?
