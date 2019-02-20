#!/bin/bash
# Sanjaya Gajurel - created on May 19, 2017

# Restores the read/write/execute permission for /tmp if not configured properly

filename="/tmp/tmpPermission.lst"

MSG="/tmp/msg"
echo "Check the following nodes for Misconfigured /tmp directory ... They will be fixed" >> $MSG
# /opt/xcat/bin/xdsh slurmrh6,slurmrh7 -t 120 "ls -l  / | grep tmp | awk '{print $2}' | grep "-" | wc -l"  | grep ".*: 1" | cut -f1 -d':'  > $filename 2> /tmp/errfile
#/opt/xcat/bin/xdsh comp200 "ls -l  / | grep tmp | awk '{print $2}' | grep "-" | wc -l"  | grep ".*: 1" | cut -f1 -d':'
/usr/local/bin/pdsh -g slurmrh6t,slurmrh7t -t 120 "ls -l  / | grep tmp | awk '{print $2}' | grep "-" | wc -l"  | grep ".*: 1" | cut -f1 -d':'  > $filename 2> /tmp/errfile
if [ -s $filename ]
then
  cat  $filename >> $MSG
  mail -s "/tmp directory misconfigured" <email-address> < $MSG
  # Fix the /tmp configuration
 for i in `cat $filename`
  do
  ssh $i chmod -R 777 /tmp
  done
fi
