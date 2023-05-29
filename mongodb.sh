echo -e '\e[33mCopy MongoDB repo file\e[0m'
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e '\e[33mInstalling MongoDB Server\e[0m'
yum install mongodb-org -y &>>/tmp/roboshop.log

#Modify the config file

echo -e '\e[33mStart MongoDB Server\e[0m'
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log