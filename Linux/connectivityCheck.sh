#!/bin/bash

connectivityOutputFile=connectivityOutput.txt
site=www.google.com
internalHost=192.168.0.1
waitTimeActive=30
waitTimeInactive=10
pingTimeout=2

out=false

while [ true ] ; do
  result=$(ping -c 1 -W $pingTimeout -n $site)
  internalResult=$(ping -c 1 -W $pingTimeout -n $internalHost)

  #Check whether external host is reachable
  while [ -z "$(echo $result | grep "bytes from")" ] ; do
    if [ "$out" == "false" ] ; then
      echo -e "Outage starting at \t$(date)" >> $connectivityOutputFile;
    fi
    #Check whether internal host is reachable
    if [ -z "$(echo $internalResult | grep "bytes from")" ] ; then
      echo "$internalHost is down as well" >> $connectivityOutputFile;
    else
      echo "$internalHost is up" >> $connectivityOutputFile;
    fi
      
    out=true;
    sleep $waitTimeInactive;
    result=$(ping -c 1 -W $pingTimeout -n $site)
    internalResult=$(ping -c 1 -W $pingTimeout -n $internalHost)
  done

  if [ "$out" == "true" ] ; then
    echo -e "Outage ending at \t$(date)\n" >> $connectivityOutputFile ;
    out=false;
  fi

  sleep $waitTimeActive;
done
