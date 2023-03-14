LOGFILE=/tmp/$COMPONENT.log
USERID=$(id -u)

if [ $USERID -ne 0 ] ; then
echo -e "\e[31m please login as root user or sudo \e[0m"
exit 1
fi

stat() {
if [ $1 -eq 0 ] ; then
echo -e "\e[32m success \e[0m"
else
echo -e "\e[31m failure \e[0m"
fi
}

NODEJS() {
echo -n "downloading components:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
stat $?

echo -n "installling nodejs:"
yum install nodejs -y  &>> $LOGFILE
stat $?
#CALLING CRETE FINCTION
CREATE_USER

DOWNLOAD_EXTARCT

NPM_INSTALL

CONFIGURE_SERVICE

}

CREATE_USER() {
id $APPUSER  &>> $LOGFILE
if [ $? -ne 0 ]; then
echo -n "adding user roboshop:"
useradd $APPUSER &>> $LOGFILE
stat $?
fi
}

MAVEN() {
    echo -n "installing maven;"
    yum install maven -y  &>> $LOGFILE
    stat $?

    CREATE_USER

    DOWNLOAD_EXTARCT

    MVM_INSTALL

    CONFIGURE_SERVICE

}

DOWNLOAD_EXTARCT(){
echo -n "downloading components:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n "performing cleanup"
rm -rf /home/$APPUSER/$COMPONENT
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE && mv $COMPONENT-main $COMPONENT  &>> $LOGFILE
stat $?

echo -n "chaning permmision:"
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT &>> $LOGFILE
stat $?
}

NPM_INSTALL() {
echo -n "installing npm package:"
cd $COMPONENT
npm install  &>> $LOGFILE
stat $?
}

CONFIGURE_SERVICE() {
echo -n "configuring service name:"
sed -i -e 's/MONGO_DNSNAME/mongodb.robot.internal/' -e 's/MONGO_ENDPOINT/mongodb.robot.internal/'  -e 's/REDIS_ENDPOINT/redis.robot.internal/' -e 's/REDIS_ENDPOINT/redis.robot.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.robot.internal/'   -e 's/CART_ENDPOINT/cart.robot.internal/'  -e 's/DBHOST/mysql.robot.internal/'  /home/roboshop/$COMPONENT/systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?

echo -n "staring $COMPONENT:"
systemctl daemon-reload  &>> $LOGFILE
systemctl start $COMPONENT &>> $LOGFILE
systemctl enable $COMPONENT &>> $LOGFILE
stat $?
}

MVM_INSTALL() {
   echo -n "installing dependencies:" 
cd $COMPONENT
mvn clean package  &>> $LOGFILE
mv target/$COMPONENT-1.0.jar $COMPONENT.jar  &>> $LOGFILE
stat $?
}

PYTHON() {
echo -n "installling python:"
yum install python36 gcc python3-devel -y  &>> $LOGFILE

CREATE_USER

DOWNLOAD_EXTARCT





}