#!/bin/bash

COMPONENT=rabbitmq

source components/common.sh

echo -n "downloading components:"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash   &>> $LOGFILE 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash   &>> $LOGFILE 
stat 4?


echo -n "installing rabbitmq:"
yum install rabbitmq-server -y &>> $LOGFILE 
stat $?

echo -n "starting rabbitmq:"
systemctl enable rabbitmq-server &>> $LOGFILE 
systemctl start rabbitmq-server &>> $LOGFILE 
stat $?


echo -n "creating application user:"
rabbitmqctl add_user roboshop roboshop123
# rabbitmqctl set_user_tags roboshop administrator
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"























echo -e "\e[32m __________ $COMPONENT Installation Completed _________ \e[0m"