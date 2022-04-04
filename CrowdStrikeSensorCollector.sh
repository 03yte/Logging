#!/bin/bash
#Author: 03yte
#V1.1 | Date: 03/30/2022
#

service="falcon-sensor"
servicePresent=$(systemctl list-unit-files | grep ${service}.service)
temp=${servicePresent[0]}
hostname=$(cat /proc/sys/kernel/hostname)
time=$(date '+%FT%T-%Z')

if [ ${#temp} == 0 ]
then
        echo  "'{\"Time\":\"$time\",\"Hostname\":\"$hostname\", \"InitState\":\"NULL\",\"RunningState\":\"NULL\"}'"
else
systemdStat=($(systemctl status ${service}.service --quiet | awk '/Active:/{print $1 $3; next} /Loaded:/ {print substr($4, 1, length($4)-1);}'))
        echo "'{\"Time\":\"$time\",\"Hostname\":\"$hostname\",\"InitState\":\"${systemdStat[0]}\",\"RunningState\":\"${systemdStat[1]}\"}'"
fi
