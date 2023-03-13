#!/bin/bash

COMPONENT=redis
APPUSER=roboshop
source components/common.sh

echo -n "downloading components:"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo  &>> $LOGFILE 
stat $?

echo -n "installation redis:"
yum install redis-6.2.11 -y  &>> $LOGFILE
stat $?

echo -n "whitelisting redis:"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
stat $?

echo -n " starting redis :"
systemctl daemon-reload  &>> $LOGFILE
systemctl enable redis  &>> $LOGFILE
systemctl start redis   &>> $LOGFILE
stat $?
