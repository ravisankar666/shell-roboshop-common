#!/bin/bash

source ./common.sh
app_name=user

app_setup
nodejs_setup
systemd_setup
app_restart
print_total_time