#!/bin/bash 
 
LOG=/tmp/mylog.log 
SECONDS=180 

 
for i in $@; do 
    echo "$i-UP!" > $LOG.$i 

done 
   
while true; do 
  for i in $@; do 

    ping -c 1 $i > /dev/null 
      if [ $? -ne 0 ]; then 
        STATUS=$(cat $LOG.$i) 
        if [ $STATUS != "$i-DOWN!" ]; then 
          echo "`date`: ping failed, $i host is down!" 
        fi 
          echo "$i-DOWN!" > $LOG.$i 
  
      else 
        STATUS=$(cat $LOG.$i)
        if [ $STATUS != "$i-UP!" ]; then 
          echo "`date`: ping OK, $i host is up!" 
        fi 
          echo "$i-UP!" > $LOG.$i 
      fi 
  done 

sleep $SECONDS 
done
