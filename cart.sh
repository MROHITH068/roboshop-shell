echo -e '\e[33mDownloading NodeJS repos\e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e '\e[33mInstalling NodeJS\e[0m'
yum install nodejs -y &>>/tmp/roboshop.log

echo -e '\e[33mAdding user roboshop\e[0m'
useradd roboshop

echo -e '\e[33mMakinging directory app\e[0m'
rm -rf /app
mkdir /app

echo -e '\e[33mDownloading Cart Content\e[0m'
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e '\e[33mInstalling Dependencies\e[0m'
npm install &>>/tmp/roboshop.log

echo -e '\e[33mSetup SystemD Service\e[0m'
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e '\e[33mStarting the Cart Service\e[0m'
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log

