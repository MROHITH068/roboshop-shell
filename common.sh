color="\e[33m"
nocolor="\e[0m"
data_log="/tmp/roboshop.log"
app_path="/app"

preapp_setup(){
  echo -e "${color}Adding user roboshop${nocolor}"
  useradd roboshop

  echo -e "${color}Makinging directory app${nocolor}"
  rm -rf ${app_path}
  mkdir ${app_path} &>>${data_log}

    echo -e "${color}Downloading ${component} Content${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${data_log}

    cd ${app_path}
    unzip /tmp/${component}.zip &>>${data_log}

}

systemd_setup(){
     echo -e "${color}Setup SystemD Service${nocolor}"
    cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>${data_log}
    echo -e "${color}Starting Shipping Service${nocolor}"

    systemctl daemon-reload &>>${data_log}
    systemctl enable ${component} &>>${data_log}
    systemctl restart ${component} &>>${data_log}

}

node_js() {

  echo -e "${color}Downloading NodeJS repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${data_log}

  echo -e "${color}Installing NodeJS${nocolor}"
  yum install nodejs -y &>>${data_log}


  preapp_setup

  echo -e "${color}Installing Dependencies${nocolor}"
  npm install &>>${data_log}

  systemd_setup
}

mongo_schema_setup(){

echo -e "${color}Adding MongoDB repo file${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${data_log}

echo -e "${color}Installing MongoDB Client${nocolor}"
yum install mongodb-org-shell -y &>>${data_log}

echo -e "${color}Loading the Schema${nocolor}"
mongo --host mongodb-dev.rohdevops.online <${app_path}/schema/$component.js &>>${data_log}
}

mysql_setup(){
   echo -e "${color}Installing MySQL Client${nocolor}"
    yum install mysql -y &>>${data_log}

    echo -e "${color}Loading the Schema${nocolor}"
    mysql -h mysql-dev.rohdevops.online -uroot -pRoboShop@1 <${app_path}/schema/$component.sql &>>${data_log}

    echo -e "${color}Setup SystemD Service${nocolor}"
    cp /root/roboshop-shell/${component}.service  /etc/systemd/system/${component}.service &>>${data_log}
}


maven(){

  echo -e "${color}Installing Maven${nocolor}"
  yum install maven -y &>>${data_log}

  preapp_setup

  echo -e "${color}Downloading Maven Dependencies${nocolor}"
  mvn clean package &>>${data_log}
  mv target/${component}-1.0.jar ${component}.jar &>>${data_log}

  mysql_setup

  systemd_setup
}

python(){

}