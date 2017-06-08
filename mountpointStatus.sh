#!/bin/bash
# Check the Mount Points
# Created By Sanjaya Gajurel on May 22,2017.

declare -a mountpointsHead=("/mnt/projects" "/mnt/genetics" "/home" "/scratch" "/usr/local" "/mnt/pan")
echo "The mountpoints to be monitored for head nodes are: ${mountpointsHead[@]}"

declare -a mountpointsCompute=("/mnt/projects" "/mnt/genetics" "/home" "/scratch" "/usr/local" "/mnt/pan")
echo "The mountpoints to be monitored for compute nodes are: ${mountpointsCompute[@]}"


echo "Check the following nodes for Missing Mount Points ...."

filename="/tmp/nodewoscratch.lst"

# For Head Nodes
for i in "${mountpointsHead[@]}"
do
  /opt/xcat/bin/xdsh <list-of-servers> "df -hP | grep $i | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile

if [ -s $filename ]
then
  cat  $filename
fi
done

# For Compute Nodes
for i in "${mountpointsCompute[@]}"
do
  /opt/xcat/bin/xdsh <compute-node-group> "df -hP | grep $i | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile
#  /opt/xcat/bin/xdsh comp100 "pan_df -hP | grep $i | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile

if [ -s $filename ]
then
  cat  $filename
fi
done
