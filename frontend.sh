#!/bin/bash

source ./common.sh




dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "disabbling nginx"

dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "enabling nginx"

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "installing ngnix"


systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "enabling nginx"
systemctl start nginx &>>$LOG_FILE
VALIDATE $? "starting nginx"

rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "Downloading frontend"

rm -rf /etc/nginx/nginx.conf
cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "copying nginx.conf"

systemctl retstart nginx
VALIDATE $? "restarting nginx"

print_total_time
