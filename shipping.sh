echo -e '\e[33mInstalling Maven\e[0m'
yum install maven -y &>>/tmp/roboshop.log

echo -e '\e[33mAdding roboshop user \e[0m'
useradd roboshop &>>/tmp/roboshop.log

echo -e '\e[33mMakinging directory app\e[0m'
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e '\e[33mDownloading Shipping Content\e[0m'
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log

echo -e '\e[33mUnzipping Shipping zip file\e[0m'
cd /app
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e '\e[33mDownloading Maven Dependencies\e[0m'
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e '\e[33mInstalling MySQL Client\e[0m'
yum install mysql -y &>>/tmp/roboshop.log

echo -e '\e[33mLoading the Schema\e[0m'
mysql -h mysql-dev.rohdevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e '\e[33mSetup SystemD Service\e[0m'
cp /root/roboshop-shell/shipping.service  /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e '\e[33mStarting Shipping Service\e[0m'
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log