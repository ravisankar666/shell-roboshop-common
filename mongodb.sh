#!/bin/bash

source ./common.sh

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "ADDING MONGO REPO"

dnf install mongodb-org -y  &>>$LOG_FILE
VALIDATE $? "installing mongodb"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "Enable Mongodb"

systemctl start mongod 
VALIDATE $? "start Mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connection to Mongodb"

systemctl restart mongod 
VALIDATE $? "Restarted Mongodb"

print_total_time

