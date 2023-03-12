#!/bin/bash

set -e

USERID=$(id -u)

if [ $USERID -ne 0 ] ; then
echo -e "\e[31m please login as root user or sudo \e[0m"
exit 1
fi

echo -e "\e[32m installing nginx \e[0m"
yum install nginx -y  &>> /tmp/frotnend.log


echo -e "\e[32m downloading component \e[0m"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"  &>> /tmp/frotnend.log

echo -e "\e[32m cleaning up \e[0m"
rm -rf * /usr/share/nginx/html 
cd /usr/share/nginx/html

echo -e "\e[32m unzipping component \e[0m"
unzip /tmp/frontend.zip &>> /tmp/frotnend.log

echo -e "\e[32m moving the component \e[0m"
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
