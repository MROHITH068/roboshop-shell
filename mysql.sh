echo -e '\e[33mDisabling the required Module\e[0m'
yum module disable mysql -y

echo -e '\e[33mAdding the Repo File\e[0m'
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e '\e[33mInstalling MySQL Server\e[0m'
yum install mysql-community-server -y

echo -e '\e[33mStarting MySQL Service\e[0m'
systemctl enable mysqld
systemctl restart start mysqld

echo -e '\e[33m Setup MySQL Password\e[0m'
mysql_secure_installation --set-root-pass RoboShop@1