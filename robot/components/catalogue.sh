#!/bin/bash

set -e
COMPONENT=catalogue
APPUSER=roboshop
source components/common.sh

echo -n -e "\e[32m downloading components \e[0m:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
stat $?

echo -n -e "\e[32m installling nodejs \e[0m:"
yum install nodejs -y  &>> $LOGFILE
stat $?

echo -n -e "\e[32m adding user roboshop \e[0m:"
id $APPUSER
# if [ $? -ne 0 ] ; then
# useradd $APPUSER
# fi
stat $?

echo -n -e "\e[32m downloading components \e[0m:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n -e "\e[32m unzipping moving components \e[0m:"
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
mv $COMPONENT-main $COMPONENT
cd /home/$APPUSER/$COMPONENT

echo -n -e "\e[32m installing npm package \e[0m:"
npm install  &>> $LOGFILE
stat $?