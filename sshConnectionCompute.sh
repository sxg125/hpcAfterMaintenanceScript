#!/bin/bash
# Sanjaya Gajurel - created on May 19, 2017

MSG="/tmp/msg"
filename="/tmp/connection.lst"
nodelist="/tmp/node.lst"
nodelistbk="/tmp/node.lst.bak"
drained="/tmp/drain.lst"

#echo "1G Connection issue is  on following RHEL7 nodes ..... They will be drained" > $MSG

#siall is the customized slurm command that list nodes witht the following format 
# NODELIST        AVA    STATE  TIMELIMIT NODE  CPUS(A/I/O/T) CPU_LOAD  MEMORY FREE_ME AVAIL_FEAT REASON
siall | awk 'NR>=2 {print $1}' > $nodelist
sed -i 's/t//g' $nodelist
for i in `cat $nodelist`
   do
      
       ssh -q $i hostname  | awk -F'.' '{print $1}' | wc -l | grep 0  > $filename 2> /tmp/errfile
       #j=`echo $i | cut -f1 -dt`t`echo $i | cut -f2 -dt`     
       t=`echo ${i:${#i} - 3}`
       j=`echo "${i/$t/t$t}"`
  if [ -s $filename ]
       then
       /usr/local/bin/siall | grep drain | grep $j | wc -l | grep 0  > $drained 2> /tmp/errfile
        if [ -s $drained ]
         then
          echo "1G Connection issue is  on following RHEL7 node(s): $i ..... They will be drained" > $MSG
          # Drain those Nodes with 1G connection
           node="$j"
           echo "The node is $node"
           scontrol Update NodeName=$node State=drain Reason="drain-1G-connection"
           mail -s "1G Connection Issue detected in compute node(s)" <email-address> < $MSG
       fi
   fi
  done
