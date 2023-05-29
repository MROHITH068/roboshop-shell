echo -e '\e[33mInstalling Nignx\e[0m'
yum install nginx -y &>>/tmp/roboshop.log

echo -e '\e[33mRemoving the old Content\e[0m'
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e '\e[33mDownloading the frontend Content\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e '\e[33mUnziping the frontend content\e[0m'
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

echo -e '\e[33mRestarting the Nginx\e[0m'
systemctl enable nginx
systemctl restart nginx &>>/tmp/roboshop.log