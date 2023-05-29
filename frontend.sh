yum install nginx -y &>>/tmp/roboshop.log

rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

cd /usr/share/nginx/html &>>/tmp/roboshop.log
unzip /tmp/frontend.zip

cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

systemctl enable nginx
systemctl restart nginx