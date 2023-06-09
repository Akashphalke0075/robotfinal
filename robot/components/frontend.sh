#!/bin/bash

set -e
COMPONENT=frontend
source components/common.sh

echo -n -e "\e[32m installing nginx \e[0m:"
yum install nginx -y  &>> $LOGFILE
stat $?

echo -n -e "\e[32m downloading component \e[0m:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n -e "\e[32m cleaning up \e[0m:"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
stat $?

echo -n -e "\e[32m unzipping component \e[0m:"
unzip /tmp/$COMPONENT.zip &>> $LOGFILE
stat $?

echo -n -e "\e[32m moving the component \e[0m:"
mv $COMPONENT-main/* .
mv static/* .
stat $?

echo -n -e "\e[32m cleaning and move confg \e[0m:"
rm -rf $COMPONENT-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
stat $?


for component in catalogue cart user shipping payment; do
echo -n "proxy reverse proxy:"
sed -i -e "/$component/s/localhost/$component.robot.internal/" /etc/nginx/default.d/roboshop.conf
stat $? 
done


echo -n -e "\e[32m starting nginx \e[0m:"
systemctl daemon-reload
systemctl enable nginx &>> $LOGFILE
systemctl restart nginx &>> $LOGFILE
stat $?