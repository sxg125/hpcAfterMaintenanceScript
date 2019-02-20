#!/bin/bash
# Sanjaya Gajurel - created on May 19, 2017

MSG="/tmp/msg"

filename="/tmp/slurmMunge.lst"

# check munge status in RHEL6 ncluding on starfish for proper operation of XDMOD
echo "Munge is not working on RHEL6 node ....." > $MSG

# We use pdsh that refer to the nodelist file at /etc/dsh/group
/usr/local/bin/pdsh -g <node-list-file> -t 120 "service munge status | grep running | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile

if [ -s $filename ]
then
  cat $filename >> $MSG
  echo "Trying to restart munge ...still manually monitor the node whether munge has started successfully" >> $MSG

  mail -s "Re-starting munge" <email-address> < $MSG

  for i in `cat $filename`
   do
   ssh $i /xcatpost/restart_munge
   done

fi

# check munge status in RHEL7
echo "Munge is not working on RHEL7 node....." > $MSG
/usr/local/bin/pdsh -g <node-list-file> -t 120 "systemctl status munge | grep running | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile

if [ -s $filename ]
then
  cat $filename >> $MSG
  echo "Trying to restart munge ... still manually monitor the node whether munge has started successfully" >> $MSG

  mail -s "Re-starting munge" <email-address> < $MSG

   for i in `cat $filename`
   do
   ssh $i /xcatpost/restart_munge
   done

fi


# Check Slurm status for RHEL7
echo "Slurm is not running on RHEL7 node ....." > $MSG
# systemctl status slurmd
/usr/local/bin/pdsh -g <node-list-file> -t 120 "systemctl status slurmd | grep running | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile

if [ -s $filename ]
then
  cat $filename >> $MSG
  echo "Trying to restart slurm ... still manually monitor the node whether slurm has started successfully" >> $MSG
  
  mail -s "Re-starting slurm" <email-address> < $MSG

  for i in `cat $filename`
   do
   ssh $i systemctl start slurmd
   done

fi

