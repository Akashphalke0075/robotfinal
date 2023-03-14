#!/bin/bash

COMPONENT=mysql
source components/common.sh

read -p 'enter my sql password:' MYSQL_PWD

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

echo -n "temporary pssword:"
DEF_ROOT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk -F ' ' '{print $NF}')
stat $?

echo show databases | mysql -uroot -p${MYSQL_PWD}  &>> $LOGFILE
if [ $? -ne 0 ]; then
echo -n "reset root password"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_PWD}';" | mysql  --connect-expired-password -uroot -p"${DEF_ROOT_PASSWORD}" &>> $LOGFILE
stat $?
fi


echo show plugins | mysql -uroot -p${MYSQL_PWD} | grep validate_password; &>> $LOGFILE 
if [ $? -eq 0 ] ; then 
    echo -n "Uninstalling Password Validate Plugin: "
    echo "uninstall plugin validate_password;" | mysql -uroot -p${MYSQL_PWD} &>> $LOGFILE 
    stat $? 
fi 