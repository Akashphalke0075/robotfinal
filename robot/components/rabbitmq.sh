#!/bin/bash

COMPONENT=rabbitmq

source components/common.sh

echo -n "downloading components:"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash   &>> $LOGFILE 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash   &>> $LOGFILE 
stat $?


echo -n "installing rabbitmq:"
yum install rabbitmq-server -y &>> $LOGFILE 
stat $?

echo -n "starting rabbitmq:"
systemctl enable rabbitmq-server &>> $LOGFILE 
systemctl start rabbitmq-server &>> $LOGFILE 
stat $?

rabbitmqctl list_users | grep roboshop &>> $LOGFILE

if [ $? -ne 0 ]; then
echo -n "creating application user:"
rabbitmqctl add_user roboshop roboshop123   
stat $?
fi

echo -n "adding tags and permisson:"
rabbitmqctl set_user_tags roboshop administrator    &>> $LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>> $LOGFILE
stat $?


echo -n "_____installation completed________"















echo -e "\e[32m __________ $COMPONENT Installation Completed _________ \e[0m"