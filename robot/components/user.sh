#!/bin/bash

COMPONENT=user
APPUSER=roboshop
source components/common.sh

echo -n "downloading components:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
stat $?

echo -n "installling nodejs:"
yum install nodejs -y  &>> $LOGFILE
stat $?

id $APPUSER  &>> $LOGFILE
if [ $? -ne 0 ]; then
echo -n "adding user roboshop:"
useradd $APPUSER &>> $LOGFILE
stat $?
fi

echo -n "downloading components:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n "unzipping moving components:"
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
rm -rf $COMPONENT
mv $COMPONENT-main $COMPONENT
cd /home/$APPUSER/$COMPONENT
stat $?

echo -n "installing npm package:"
npm install  &>> $LOGFILE
stat $?

echo -n "chaning permmision:"
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT &>> $LOGFILE
stat $?

echo -n "configuring service name:"
sed -i -e 's/MONGO_ENDPOINT/mongodb.robot.internal/'  -e 's/REDIS_ENDPOINT/redis.robot.internal/'   /home/roboshop/$COMPONENT/systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?

echo -n "staring $COMPONENT:"
systemctl daemon-reload  &>> $LOGFILE
systemctl enable catalogue &>> $LOGFILE
systemctl start catalogue &>> $LOGFILE
stat $?

echo -n "_____installation completed________"