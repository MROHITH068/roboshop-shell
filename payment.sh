echo -e '\e[33mInstall Python package\e[0m'
yum install python36 gcc python3-devel -y

echo -e '\e[33mUser Add Roboshop\e[0m'
useradd roboshop

echo -e '\e[33mMaking Directory App\e[0m'
mkdir /app

echo -e '\e[33m Downloading the payment content\e[0m'
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip

echo -e '\e[33mPip installing requirements\e[0m'
cd /app
pip3.6 install -r requirements.txt

echo -e '\e[33mSetting up Service\e[0m'
cp /root/roboshop-shell/payment.service   /etc/systemd/system/payment.service

echo -e '\e[33mStarting Service\e[0m'
systemctl daemon-reload
systemctl enable payment
systemctl restart payment