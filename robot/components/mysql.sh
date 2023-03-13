#!/bin/bash

COMPONENT=mysql
source components/common.sh

echo -n "downloading component:"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo   &>> $LOGFILE
stat $?

echo -n "installing mysql:"
yum install mysql-community-server -y   &>> $LOGFILE
stat $?

echo -n "starting mysql:"
systemctl enable mysqld  &>> $LOGFILE
systemctl start mysqld  &>> $LOGFILE
stat $?

