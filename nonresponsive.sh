#!/bin/bash
# Original by S. Gajurel

MSG="/tmp/msg"
filename="/tmp/slurmstepdError.lst"
# Check Non Responsive Node

ssh smaster siall | grep down | grep 'Not responding' | awk '{print $1}'   > $filename 2> /tmp/errfile
if [ -s $filename ]
then
  echo "Node is non-responsive. Rebooting the nodes ..." > $MSG
  sed -i 's/t//g' $filename
  for i in `cat $filename`
    do
      echo "Rebooting node $i" >> $MSG
       ssh xmaster rpower $i boot
       ssh $i /xcatpost/rh7remount
    done
      mail -s "Non-responsive Node  Detected in Rider" <email-address> < $MSG
fi
