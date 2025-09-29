#!/bin/bash

source ./common.sh
check_root


cp rabbitmq.repo  /etc/yum.repos.d/rabbitmq.repo

dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "installing rabbitmq-server"

systemctl enable rabbitmq-server &>>$LOG_FILE
VALIDATE $? "enabling rabbitmq"

systemctl start rabbitmq-server &>>$LOG_FILE
VALIDATE $? "starting rabbitmq"

rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
VALIDATE  $? "adding system user"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "setting_permissions"

print_total_time