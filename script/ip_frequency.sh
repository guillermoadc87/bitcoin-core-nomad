#!/bin/bash

#IFS="\n"

if [ ! -f ./$1 ]; then
    echo "Logfile $1 does not exist"
    exit 2
fi

logfile=$(<request.log)
#echo $logfile

read -ra arr <<< "$logfile"
echo "${arr[0]}"