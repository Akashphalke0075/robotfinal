#!/bin/bash

set -e
COMPONENT=frontend
source components/common.sh

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo   &>> $LOGFILE

yum install -y mongodb-org  &>> $LOGFILE


# systemctl enable mongod
# systemctl start mongod
