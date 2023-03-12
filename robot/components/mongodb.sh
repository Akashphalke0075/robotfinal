#!/bin/bash

set -e
COMPONENT=mongodb
source components/common.sh

echo -n -e "\e[32mdownloading componenets \e[0m:"
curl -s -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo   &>> $LOGFILE
stat $?

echo -n -e "\e[32minstalling monodb \e[0m:"
yum install -y $COMPONENT-org  &>> $LOGFILE
stat $?

# systemctl enable mongod
# systemctl start mongod
