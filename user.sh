echo -e '\e[33mDownloading NodeJS repos\e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e '\e[33mInstalling NodeJS\e[0m'
yum install nodejs -y &>>/tmp/roboshop.log

echo -e '\e[33mAdding user roboshop\e[0m'
useradd roboshop

echo -e '\e[33mMakinging directory roboshop\e[0m'
rm -rf /app
mkdir /app

echo -e '\e[33mDownloading User Content\e[0m'
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e '\e[33mInstalling Dependencies\e[0m'
npm install &>>/tmp/roboshop.log

echo -e '\e[33mSetup SystemD Service\e[0m'
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e '\e[33mReloading the Service\e[0m'
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log

echo -e '\e[33mAdding MongoDB repo file\e[0m'
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e '\e[33mInstalling MongoDB Client\e[0m'
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e '\e[33mLoading the Schema\e[0m'
mongo --host mongodb-dev.rohdevops.online </app/schema/user.js &>>/tmp/roboshop.log
