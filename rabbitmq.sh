echo -e '\e[33mConfigure YUM Repos\e[0m'
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e '\e[33mConfigure YUM Repos for RabbitMQ\e[0m'
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e '\e[33mInstall RabbitMQ\e[0m'
yum install rabbitmq-server -y

echo -e '\e[33mStart RabbitMQ Service\e[0m'
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e '\e[33mCreate one user for Application\e[0m'
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

