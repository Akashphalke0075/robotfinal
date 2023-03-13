#!/bin/bash

COMPONENT=user
APPUSER=roboshop
source components/common.sh

NODEJS


# echo -n "downloading components:"
# curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  &>> $LOGFILE
# stat $?

# echo -n "unzipping moving components:"
# cd /home/$APPUSER
# unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
# rm -rf $COMPONENT
# mv $COMPONENT-main $COMPONENT
# stat $?

# echo -n "installing npm package:"
# cd /home/$APPUSER/$COMPONENT
# npm install  &>> $LOGFILE
# stat $?

# echo -n "chaning permmision:"
# chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT &>> $LOGFILE
# stat $?

# echo -n "configuring service name:"
# sed -i -e 's/MONGO_DNSNAME/mongodb.robot.internal/' /home/roboshop/$COMPONENT/systemd.service
# mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
# stat $?

# echo -n "staring $COMPONENT:"
# systemctl daemon-reload  &>> $LOGFILE
# systemctl start $COMPONENT &>> $LOGFILE
# systemctl enable $COMPONENT &>> $LOGFILE
# stat $?

echo -n "_____installation completed________"