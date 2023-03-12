#!/bin/bash

COMPONENT=catalogue
APPUSER=roboshop
source components/common.sh

echo -n -e "\e[32m downloading components \e[0m:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
stat $?

echo -n -e "\e[32m installling nodejs \e[0m:"
yum install nodejs -y  &>> $LOGFILE
stat $?

id $APPUSER  &>> $LOGFILE
if [ $? -ne 0 ]; then
echo -n -e "\e[32m adding user roboshop \e[0m:"
useradd $APPUSER &>> $LOGFILE
stat $?
fi

echo -n -e "\e[32m downloading components \e[0m:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n -e "\e[32m unzipping moving components \e[0m:"
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
rm -rf $COMPONENT
mv $COMPONENT-main $COMPONENT
cd /home/$APPUSER/$COMPONENT
stat $?

echo -n -e "\e[32m installing npm package \e[0m:"
npm install  &>> $LOGFILE
stat $?

echo -n -e "\e[32m chaning permmision \e[0m:"
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT
stat $?
