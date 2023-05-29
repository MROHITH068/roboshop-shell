echo -e '\e[33mDownloading NodeJS repos\e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e '\e[33mInstalling NodeJS\e[0m'
yum install nodejs -y

echo -e '\e[33mAdding user roboshop\e[0m'
useradd roboshop

echo -e '\e[33mMakinging directory roboshop\e[0m'
rm -rf app
mkdir /app

echo -e '\e[33mDownloading catalogue Content\e[0m'
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app

echo -e '\e[33mInstalling Dependencies\e[0m'
npm install

echo -e '\e[33mReloading the Service\e[0m'
systemctl daemon-reload

echo -e '\e[33mAdding MongoDB repo file\e[0m'
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e '\e[33mInstalling MongoDB Client\e[0m'
yum install mongodb-org-shell -y

echo -e '\e[33mLoading the Schema\e[0m'
mongo --host mongodb-dev.rohdevops.online </app/schema/catalogue.js
