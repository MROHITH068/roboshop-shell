echo -e '\e[33mCopy MongoDB repo file\e[0m'
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e '\e[33mInstalling MongoDB Server\e[0m'
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e '\e[33mModify the config file\e[0m'
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>/tmp/roboshop.log

echo -e '\e[33mStart MongoDB Server\e[0m'
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log