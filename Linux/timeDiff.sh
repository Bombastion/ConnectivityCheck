#!/bin/bash

file=/home/orangecat/scripts/connectivityOutput.txt
grep "start" $file | awk '{print $4" " $5" " $6" " $7" " $8" " $9}' | sed 's/\\t//'> startTimes.out
grep "end" $file | awk '{print $4" " $5" " $6" " $7" " $8" " $9}' | sed 's/\\t//'> endTimes.out

while read -r startLog <&3 && read -r endLog <&4; do
  echo 'Interval for outage starting at '$startLog': '$(($(date -d "$endLog" +%s) - $(date -d "$startLog" +%s)));
done 3<startTimes.out 4<endTimes.out
