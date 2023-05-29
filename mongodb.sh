echo -e '\e[33Copy MongoDB repo file\[e0m'
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e '\e[33Installing MongoDB Server\[e0m'
yum install mongodb-org -y

echo -e '\e[33Start MongoDB Server\[e0m'
systemctl enable mongod
systemctl restart mongod