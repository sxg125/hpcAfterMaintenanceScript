filename="/tmp/conn.lst"
nodelist="/tmp/headnode.lst"
# Check Connection status for Head Nodes
#echo "1G Connection issue is  on following head nodes ..."

#We are using PDSH/PDCP for which the nodes can be lised as a group at /etc/dsh/group
cat /etc/dsh/group/<file-with-node-list> > $nodelist

  for i in `cat $nodelist`
   do
      ssh -q $i hostname  | awk -F'.' '{print $1}' | wc -l | grep 0  > $filename 2> /tmp/errfile


  if [ -s $filename ]
       then
           echo "1G Connection issue is  on following head node(s):$i ..." >> $MSG
           mail -s "1G Connection Issue detected in head node" <email-address> < $MSG
   fi
  done
