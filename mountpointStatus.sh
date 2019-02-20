#!/bin/bash
# Check the Mount Points
# Created By Hadrian Djohari (20180125)
# Modified by Sanjaya Gajurel (20190219)

HEADOUT="/tmp/head.lst"
COMPOUT="/tmp/comp.lst"
COMPOUT2="/tmp/comp2.lst"
MISSING="/tmp/missing.lst"
TMPLIST="/tmp/tmp.lst"
HEADNODES="/tmp/headnodes.lst"
COMPNODES="/tmp/computenodes.lst"
#COMPNODES2="/etc/dsh/group/slurmrh7t"

#declare -a MOUNTPT=("/home" "/scratch" "/usr/local" "/mnt/pan" "/mnt/projects" "/mnt/genetics")
#declare -a MOUNTPT2=("/mnt/rds/genetics01" "/mnt/rds/redhen01" "/mnt/rds/redhen" "/mnt/rds/rcci" "/mnt/rds/txl80")
declare -a MOUNTPT=("/home" "/scratch" "/usr/local" "/mnt/pan" "/mnt/projects" "/mnt/genetics" "/mnt/rds/genetics01" "/mnt/rds/redhen" "/mnt/rds/rcci" "/mnt/rds/txl80" "/mnt/rds/ski")

# echo "The mountpoints to be monitored are: ${MOUNTPT[@]}" > $MISSING
echo > $TMPLIST
# echo > $MISSING  #Empty File check fails with echo

# For Head Nodes
/usr/local/bin/pdsh -g headrh7 -t 120 hostname 2>/dev/null | cut -f1 -d":" > $HEADNODES
/usr/local/bin/pdsh -g headrh7 -t 120 "df -hP" > $HEADOUT

# Go through the each mount point and check if it is missing
# Then devise a way to mount it or complain loudly via email

for i in "${MOUNTPT[@]}"
do
  for j in `cat $HEADNODES`
  do
    echo "$j $i: `cat $HEADOUT | grep $j | grep $i | wc -l`" >> $TMPLIST
  done
done

# For compute nodes
#/usr/local/bin/pdsh -w comp[032-055]t,comp[057-065]t,comp[067-252]t,gpu[005-038]t,smp[02-07]t -t 30 -u 30 hostname 2>/dev/null | cut -f1 -d":" > $COMPNODES
/usr/local/bin/pdsh -g slurmrh7t -t 120 hostname 2>/dev/null | cut -f1 -d":" > $COMPNODES
/usr/local/bin/pdsh -g slurmrh7t -t 120 "df -hP" > $COMPOUT

# Go through the each mount point and check if it is missing
# Then devise a way to mount it or complain loudly via email

for i in "${MOUNTPT[@]}"
do
  for j in `cat $COMPNODES`
  do
    echo "$j $i: `cat $COMPOUT | grep $j | grep $i | wc -l`" >> $TMPLIST
  done
done

cat $TMPLIST | grep ".*: 0" | cut -f1 -d':' | sort > $MISSING

# Set to remount (only for non-panasas)

if [ -s ${MISSING} ]
then
# Mail to the admin
cat $MISSING | mail -s "Mounting points missing (if any) & fixed" sxg125@case.edu

# Mount the mountpoints
  for node in `cat $MISSING | cut -f1 -d' ' | uniq | tail -n+2`
   do
    ssh $node /xcatpost/rh7remount
    ssh $node mount $mtpt
   done
fi

