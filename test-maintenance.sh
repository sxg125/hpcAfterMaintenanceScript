#!/bin/bash
# Sanjaya Gajurel - created on May 19, 2017

# Check Connection to Head nodes
sh sshConnectionHeadNodes.sh

# Check License Status
sh licenseStatus.sh

#Check Mountpint Status
sh mountpointStatus.sh

# Check Connection to Head nodes
#ssh sshConnectionHeadNodes.sh

filename="/tmp/nodewoscratch.lst"
# Check Slurm status
echo "Slurm is not running on ....."
/opt/xcat/bin/xdsh <node-group> "service slurm status | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile
if [ -s $filename ]
then
  cat $filename
fi

# check munge status including on starfish for proper operation of XDMOD
echo "Munge is not working on ....."
/opt/xcat/bin/xdsh <node-group> "service munge status | wc -l" | grep ".*: 0" | cut -f1 -d':' > $filename 2> /tmp/errfile
if [ -s $filename ]
then
  cat $filename
fi

# Submit MPI job
echo "Submitting MPI Job now ...."
ssh  <login-node> "srun -N 4 -n 16 <path-to-mpipi/my_program"
