#!/bin/bash

set -e
COMPONENT=frontend
source components/common.sh

echo -n -e "\e[32m downloading componenets \e[0m:"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo   &>> $LOGFILE
stat $?

echo -n -e "\e[32m installing monodb \e[0m:"
yum install -y mongodb-org  &>> $LOGFILE
stat $?

# systemctl enable mongod
# systemctl start mongod
